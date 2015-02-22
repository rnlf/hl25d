--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
BulletImpact = Entity:extend()

function BulletImpact:new(x,y,z)
  BulletImpact.super.new(self)
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
  self.solid = false
  self.size = 0
  self:loadImage("data/image/bulletimpact.png", 16)
  self.origin:set(8,8)
  self.scale:set(0.1, 0.1)
  self.noWallCollisions = true
  self.tween:to(self, 0.25, {alpha = 0})
    :oncomplete(
      function()
        self:kill()
      end)
end
