--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'weapon.weapon'
require 'bullet'
require 'hud.glockhudelement'

Glock = Weapon:extend()

Glock.imageName = 'glock17'
Glock.maxAmmo = 15
Glock.maxReserveAmmo = 90
Glock.damage = 8


function Glock:new(owner)
  Glock.super.new(self, owner)
  self.loadedAmmo = self.maxAmmo
  self.timer = Timer()
  self.hudElement = GlockHudElement(owner.hud, self)
end


function Glock:update(dt)
  self.timer:update(dt)
end


function Glock:fire(timeScale, deviation)
  if self.canFire then
    self.canFire = false
    if self.loadedAmmo > 0 then
      --  Shoot
      Bullet.shoot(self.owner.x, self.owner.y, self.owner.facing,
                  Glock.damage, self.owner, nil, deviation)
      self.loadedAmmo = self.loadedAmmo - 1
      self.timer:delay(function() self.canFire = true end, 0.25 * timeScale)
      self.owner.hud:refresh()
      -- Do juicy stuff
      G.state:shake()
      local overlayOffset = G.state.weaponOverlay.offset
      overlayOffset:set(8, 8)
      self.owner.tween:to(overlayOffset, .3, { x = 0, y = 0 })
      self:expelCasing()
      self:knockback(1.5)

     
    else
      print("click")
      if self.owner.items.glockAmmo > 0 then
        self:reload()
      else
        self.canFire = false
        self.timer:delay(function() self.canFire = true end, timeScale * 0.25)
      end
    end
  end
end


function Glock:firePrimary()
  self:fire(1, 0.01)
end


function Glock:fireSecondary()
  self:fire(0.6, 0.03)
end


function Glock:reload()
  if self.loadedAmmo == self.maxAmmo then return end

  if self.owner.items.glockAmmo > 0 then
    self.canFire = false
    self.timer:delay(function()
      local freeSlots = self.maxAmmo - self.loadedAmmo
      local addAmmo = math.min(self.owner.items.glockAmmo, freeSlots)
      self.owner.items.glockAmmo = self.owner.items.glockAmmo - addAmmo
      self.loadedAmmo = self.loadedAmmo + addAmmo
      self.canFire = true
      self.owner.hud:refresh()
    end, 1.5)
  end
end


function Glock:equip(onFinish)
  G.state.weaponOverlay.origin:set(20,25)
  self.canFire = true
  self.hudElement:show()
  Glock.super.equip(self, onFinish)
end


function Glock:unequip(onFinish)
  self.hudElement:hide()
  Glock.super.unequip(self, onFinish)
end


function Glock:usable()
  return self.loadedAmmo > 0 or self.owner.items.glockAmmo > 0
end
