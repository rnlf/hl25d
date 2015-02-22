--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "group"

-- The main HUD stuff which is displayed over everything when in the PlayState.
-- Doesn't include the weapon overlay which is handled by WeaponOverlay
-- (weaponoverlay.lua). Ammo, HP, flashlight, damage displays etc. should live
-- here.

Hud = Group:extend()

Hud.elementColor = 0xFFDC00
Hud.elementAlpha = .7


function Hud:new(player)
  Hud.super.new(self)
  self.player = player
  -- TODO : Err'thing
  -- Add some test text to make sure everything is kicking, TODO: Remove this

  self.hurtIndicators = {}
  for i = 1, 4 do
    local hurtIndicator = Entity()
    local angle = i/2 * math.pi
    hurtIndicator:loadImage('data/image/hurtindicator.png', 120, 30)
    hurtIndicator.origin:set(60, 15)
    hurtIndicator.x = math.sin(angle) * 60 + G.width / 2
    hurtIndicator.y = - math.cos(angle) * 60 + G.height / 2
    hurtIndicator.angle = angle
    hurtIndicator.alpha = 0
    self:add(hurtIndicator)
    table.insert(self.hurtIndicators, hurtIndicator)
  end

  self.elements = {}
end


function Hud:update(dt)
  Hud.super.update(self,dt)
end


function Hud:refreshHurt(angle)
  local idx = 2
  if angle >= -math.pi / 4 and angle < math.pi / 4 then
    idx = 4
  elseif angle >= math.pi / 4 and angle < 3 * math.pi / 4 then
    idx = 1
  elseif angle >= -3 * math.pi / 4 and angle < -math.pi / 4 then
    idx = 3
  end

  self.hurtIndicators[idx].alpha = 1
  self.tween:to(self.hurtIndicators[idx], .5, { alpha = 0 })

end


function Hud:refresh()
  for _,i in pairs(self.elements) do
    i:refresh()
  end
end


function Hud:addElement(element)
  self.elements[element] = element
  self:add(element)
end


function Hud:removeElement(element)
  self.elements[element] = nil
  self:remove(element)
end
