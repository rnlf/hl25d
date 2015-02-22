--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'item.item'

Battery = Item:extend()

Battery.defaultHeal = 30


function Battery:new()
  Battery.super.new(self)

  self:loadImage("data/image/items/battery.png", 7)
  self:addAnimation("glow", {1,2,3,2}, 4)
  self.heals = self.defaultHeal
  self.size = 0.3
  self.scale:set(0.3,0.3)

  -- flag for Armor class that healing is intented for it 
  -- rather than for the real health
  self.hev = true
end


function Battery:onCollect(player)
  if not player.health.armor then return end

  if player.health.armor < player.health.maxArmor then
    player.health:heal(self.heals, self)
    Battery.super.onCollect(self,player)
    self:kill()
  end
end
