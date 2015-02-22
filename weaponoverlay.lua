--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "entity"

-- The 2d weapon overlay, the flat weapon sprite image you can see over
-- everything when you walk.

WeaponOverlay = Entity:extend()

function WeaponOverlay:new(player)
  WeaponOverlay.super.new(self)
  self.solid = false
  self.player = player
  self.elapsed = 0
  self.scale.x = 3
  self.scale.y = 3
  self.offset = Vec3()
  self.origin:set(0,0)
end


function WeaponOverlay:update(dt)
  WeaponOverlay.super.update(self, dt)
  local mul = self.player.velocity:magnitude() / self.player.maxVelocity 
  self.elapsed = self.elapsed + dt * mul
  -- Sway Weapon
  local x = self.elapsed * 5
  self.x = G.width - 90 + math.cos(x) * 10 + self.offset.x
  self.y = G.height + math.sin(x % math.pi) * 6 + self.offset.y
end


function WeaponOverlay:switchTo(weapon, onSwitched)
  local image = weapon.imageName
  local time = 1
  local filename = "data/image/weapon/" .. image .. ".png"
  if image ~= self.current then
    self.current = image
    local drawWeapon = function()
      self.weapon = weapon
      self:loadImage(filename)
      self.weapon:equip(onSwitched)
    end
    if not self.image then
      drawWeapon()
    else
      if self.weapon then
        self.weapon:unequip(drawWeapon)
      else
        drawWeapon()
      end
    end
  end
end
