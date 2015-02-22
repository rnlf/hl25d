--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
AlienBlood = Entity:extend()

function AlienBlood:new(x,y,z,size)
  AlienBlood.super.new(self)
  self.x = x
  self.y = y
  self.z = z
  self.scale:set(size,size)
  self.solid = false
  self:loadImage("data/image/alienblood1.png", 32)
  self.origin:set(16,16)
  self:addAnimation("splash", {1,2,3,4}, 32)
  self.timer:delay(function() self:kill() end, 0.125)
  self.noWallCollisions = true
end
