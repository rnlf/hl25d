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

Crowbar = Weapon:extend()

Crowbar.imageName = 'crowbar'
Crowbar.swingTime = 0.25
Crowbar.damage = 20
Crowbar.strikeDist = .75

function Crowbar:new(owner)
  Crowbar.super.new(self, owner)
  self.swingPos = 0
  self.swinging = false
  self.timer = Timer()
end


function Crowbar:update(dt)
  self.timer:update(dt)
  if self.swinging then
    G.state.weaponOverlay.angle = -self.swingPos
    G.state.weaponOverlay.offset.x = 80*self.swingPos
  end
end


function Crowbar:firePrimary()
  if not self.swinging then
    self.swinging = true
    self.timer:delay(
      function() 
        Bullet.shoot(self.owner.x, self.owner.y, self.owner.facing, 
                     Crowbar.damage, self.owner, Crowbar.strikeDist)

        self.timer:delay(
          function()
            self.swinging = false
          end, self.swingTime / 2)
      end, self.swingTime * 0.75)
  end
end


function Crowbar:unequip(onFinish)
  self.swinging = false
  Crowbar.super.unequip(self,onFinish)
end


function Crowbar:equip(onFinish)
  G.state.weaponOverlay.origin:set(20,40)
  self.swinging = false
  Crowbar.super.equip(self,onFinish)
end
