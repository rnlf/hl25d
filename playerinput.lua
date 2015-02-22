--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local Action = Object:extend()

function Action:new(name, fn, dontrepeat)
  self.keyCheckFunction = function() return false end
  self.mouseCheckFunction = function() return false end
  self.wasActive = false

  if G.config.controls[name] then
    if G.config.controls[name].key then
      self.keyCheckFunction = function()
        return love.keyboard.isDown(G.config.controls[name].key)
      end
    end
    if G.config.controls[name].mouse then
      if dontrepeat then
        self.mouseCheckFunction = function()
          return G.mouse.pressed[G.config.controls[name].mouse]
        end
      else
        self.mouseCheckFunction = function()
          return G.mouse.down[G.config.controls[name].mouse]
        end
      end
    end
  end

  self.fn = fn
end


function Action:test()
  if self.mouseCheckFunction() or self.keyCheckFunction() then
    self.fn(self.wasActive)
    self.wasActive = true
  else
    self.wasActive = false
  end
end



PlayerInput = Object:extend()

function PlayerInput:new(player)
  self.player = player
  self.movement = Vec3()

  self.actions = {
    Action('forward',        function() self:move( 1, 0) end),
    Action('backward',       function() self:move(-1, 0) end),
    Action('left',           function() self:move( 0,-1) end),
    Action('right',          function() self:move( 0, 1) end),
    Action('nextweapon',     function() player:switchWeapon(1) end, true),
    Action('previousweapon', function() player:switchWeapon(-1) end, true),
    Action('use',            function(wasActive) player:use(wasActive) end),

    Action('turnleft',
      function()
        player.facing = player.facing
          - love.timer.getDelta() * G.config.keyturnspeed
      end),

    Action('turnright',
      function()
        player.facing = player.facing
          + love.timer.getDelta() * G.config.keyturnspeed
      end),

    Action('attack1',
      function()
        if player:currentWeapon() then
          player:currentWeapon():firePrimary()
        end
      end),

    Action('attack2',
      function()
        if player:currentWeapon() then
          player:currentWeapon():fireSecondary()
        end
      end),

    Action('reload',
      function()
        if player:currentWeapon() then
          player:currentWeapon():reload()
        end
      end)
  }
end


function PlayerInput:update()
  self.movement:set(0,0)
  for i,action in ipairs(self.actions) do
    action:test()
  end

  local dirX, dirY = tools.rotate(self.movement.x,
                                  self.movement.y,
                                  self.player.facing)

  self.player:movementInput(tools.scale(dirX, dirY, self.player.runAccel))
end


function PlayerInput:move(x,y)
  self.movement.x = self.movement.x + x
  self.movement.y = self.movement.y + y
end
