--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'entity'
require 'armor'

require 'weapon.crowbar'
require 'weapon.glock'
require 'playerinput'
require 'hud.hud'
require 'hud.healthhudelement'

-- The main player entity. This is the entity "behind the camera", it is
-- controlled by the user.


Player = Entity:extend()
Player.runAccel = 300
Player.useDist = .75
Player.defaultViewHeight = .5
Player.bobAmplitude = .008
Player.bobFrequency = 7


function Player:new()
  Player.super.new(self)
  self.maxVelocity = 5
  self.drag = 8
  self.height = 0.5

  self.input = PlayerInput(self)
  self.accel.z = -3

  self.health = Armor(100, 100, 100, 0)
  self.hud = Hud(self)
  self.health.onHurt = function(health, source)
    local angle = lume.angle(self.x, self.y, source.last.x, source.last.y) - 
                  self.facing
    if angle < -math.pi then
      angle = angle + math.pi * 2
    end
    if angle > math.pi then
      angle = angle - math.pi * 2
    end

    G.shake(5, .2)
    self.hud:refreshHurt(angle)
    self.hud:refresh()
  end

  self.health.onRecharge = function(health, source)
    self.hud:refresh()
  end

  self.health.onHeal = self.health.onRecharge

  self.health.onDie = function(source)
    self.accel:set(0,0)
    self.died = true
    self.hud:refresh()
    G.state:flash(0xFF0000, 3, .8)
    self.tween:to(self, .5, {height = 0.05})
      :ease('quadin')
      :oncomplete(function()
        self.timer:delay(function()
          G.state:spawnDeathMenu()
        end, 2)
      end)
  end

  self.items = {
    glockAmmo = 30
  }
  self.weapons = { 
    Crowbar(self),
    Glock(self)
  }
  self.currentWeaponIdx = 0
  self.switchingWeapons = false
  self.healthHud = HealthHudElement(self.hud)
  self.healthHud:show()

  self.bobTime = 0
  self.died = false
  self.height = self.defaultViewHeight
end


function Player:updateInput(dt)
  if self.died then return end
  -- Handle mouse
  local mousespeed = lume.clamp(G.config.mousespeed * .2, 0, 10e1)
  self.facing = self.facing + math.rad(G.mouse.velocity.x * mousespeed)
  self.input:update()
end


function Player:update(dt)
  self.bobTime = self.bobTime + dt
  self:updateInput(dt)
  if self:currentWeapon() then
    self:currentWeapon():update(dt)
  end
  Player.super.update(self, dt)
end


function Player:findUsableWeapon(dir)
  -- [TODO: Add skipping of weapons with w:usable() == false]

  return (self.currentWeaponIdx + dir - 1) % #self.weapons + 1
end


function Player:switchWeapon(dir)
  if self.switchingWeapons then
    return
  end

  local nextWeaponIdx = self:findUsableWeapon(dir)
  if nextWeaponIdx == self.currentWeaponIdx then
    return
  end

  self.switchingWeapons = true
  local nextWeapon = self.weapons[nextWeaponIdx]
  
  G.state.weaponOverlay:switchTo(nextWeapon, 
                                 function() 
                                   self.currentWeaponIdx = nextWeaponIdx
                                   self.switchingWeapons = false 
                                 end)
end


function Player:currentWeapon()
  return self.weapons[self.currentWeaponIdx]
end


function Player:use(wasActive)
  local impact = G.state.level:castRay(self.x, self.y,
                                       self.facing, self.useDist)
  if impact.type == 'wall' and impact.wall.face then
    local usabletile = G.state.level:getUsableTile(impact.wall.mapX,
                                                   impact.wall.mapY,
                                                   impact.wall.face)
    if usabletile then
      usabletile:onUse(self, wasActive)
    end
  elseif impact.type == 'entity' then
    impact.entity:onUse(self, wasActive)
  end
end


function Player:getViewHeight()
  if self.died then
    return self.z + self.height
  else
    return self.z + self.height +
           self.bobAmplitude * self.velocity:magnitude() *
           math.abs(math.sin(self.bobTime * self.bobFrequency))
  end
end


function Player:movementInput(x,y)
  if self.z == 0 then
    self.accel:set(x,y)
  end
end

