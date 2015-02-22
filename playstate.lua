--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "state"
require "group"
require "raycaster"
require "player"
require "weaponoverlay"
require "mob.headcrab"
require "usable.firstaidstation"
require "usable.rechargestation"
require "gamemenu"
require "deathmenu"
require "level"

-- The main state of play -- if you're playing the game and not on some kind of
-- menu or cutscene then you're likely in this state.


PlayState = State:extend()

function PlayState:create(mapname, player)
  mapname = mapname or "level001"

  -- Init
  lume.trace("initing playstate")
  G.mouse.lock()
  self.world = Group()
  self.player = player or Player()
  self.weaponOverlay = WeaponOverlay(self.player)

  self.world:add(self.player)
  self:add(self.weaponOverlay)
  self:add(self.player.hud)

  -- Init map
  self.level = Level(mapname)

  -- Init raycaster
  self.raycaster = raycaster.Renderer(self.level, 60, G.width, G.height)
  self.raycaster.debug = G.config.debug

  -- Init map's objects
  EntityFactory.createEntities(self.level.mapdata, self)

  self.level:init()

  for i,v in ipairs(self.world.members) do
    v:onSpawn()
  end

  self.screenShake = 0

end

function PlayState:shake(amount, time) 
  self.screenShake = amount or 3
  self.tween:to(self, time or .2, { screenShake = 0 })
end


function PlayState:multiSubtitle(text, x, y, size, scrollTime,
                                 charDelay, fadeTime, idx)
  idx = idx or 1

  if idx <= #text then
    local txt, delay = unpack(text[idx])
    self:subtitle(txt, x, y, size, scrollTime, charDelay, delay, fadeTime)
    self.timer:delay(function()
      self:multiSubtitle(text, x, y, size, scrollTime,
                         charDelay, fadeTime, idx + 1) 
    end, delay + 1)
  end
end


function PlayState:subtitle(text, x, y, size, scrollTime,
                            charDelay, fadeDelay, fadeTime)
  local txt = Entity()
  txt:loadFont(nil, size)
  local w = txt.font:getWidth(text)
  txt:setText("")
  self:add(txt)
  txt:warp(x - w / 2,y)
  local drawlen = 0
  local more = function()
    drawlen = drawlen + 1
    txt:setText(text:sub(1,drawlen))
    if drawlen == #text then
      self.timer:abort()
      if scrollTime and scrollTime > 0 then
        self.tween:to(txt, scrollTime, {y = y - size - 1})
      end
      self.tween:to(txt, fadeTime or 3, {alpha = 0})
        :delay(fadeDelay or 2)
        :oncomplete(function()
          self:kill()
        end)
    end
  end
  self.timer:loop(more, charDelay or 0.03)
end


function PlayState:update(dt)
  if self.gameMenu then
    self.gameMenu:update(dt)
  else
    self.world:update(dt)
    self.level:update(dt)
    self.level:collideGroup(self.world)
    self.level.triggers:test(self.player.x, self.player.y)
    G.screenShake = self.screenShake
    PlayState.super.update(self, dt)
  end
end


function PlayState:spawnGameMenu()
  self.gameMenu = GameMenu()
  self.gameMenu.onKill = function() self.gameMenu = nil end
  self:add(self.gameMenu)
end


function PlayState:spawnDeathMenu()
  self.gameMenu = DeathMenu()
  self:add(self.gameMenu)
end


function PlayState:onKeyDown(key)
  if self.gameMenu then self.gameMenu:onKeyDown(key) end
  if key == "escape" and not self.gameMenu then
    self:spawnGameMenu()
  end
end


function PlayState:draw()
  self.raycaster:draw(self.player.x, self.player.y,
                      math.cos(self.player.facing),
                      math.sin(self.player.facing),
                      self.world.members, self.player:getViewHeight())
  PlayState.super.draw(self)
end
