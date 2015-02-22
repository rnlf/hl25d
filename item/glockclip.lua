--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'item.item'

GlockClip = Item:extend()

GlockClip.defaultAmmoPerClip = 15


function GlockClip:new()
  GlockClip.super.new(self)
  self:loadImage("data/image/items/glock_clip.png")
  self:addAnimation("lie", {1}, 1)
  self.ammoPerClip = self.defaultAmmoPerClip
  self.size = 0.3
  self.scale:set(0.2,0.2)

end


function GlockClip:onCollect(player)
  if player.items.glockAmmo < Glock.maxReserveAmmo then
    player.items.glockAmmo = math.min(Glock.maxReserveAmmo, player.items.glockAmmo + self.ammoPerClip)
    GlockClip.super.onCollect(self,player)
    self:kill()
  end
end


