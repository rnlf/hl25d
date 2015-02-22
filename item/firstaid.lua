--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'item.item'

FirstAid = Item:extend()

FirstAid.defaultHeal = 30


function FirstAid:new()
  FirstAid.super.new(self)

  self:loadImage("data/image/items/firstaid.png")
  self:addAnimation("lie", {1}, 1)
  self.heals = self.defaultHeal
  self.size = 0.3
  self.scale:set(0.1,0.1)
end


function FirstAid:onCollect(player)
  if player.health.health < player.health.maxHealth then
    player.health:heal(self.heals, self)
    FirstAid.super.onCollect(self,player)
    self:kill()
  end
end


