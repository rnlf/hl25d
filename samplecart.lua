--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
SampleCart = Entity:extend()

function SampleCart:new()
  SampleCart.super.new(self)

  self:loadImage("data/image/samplecart.png", 40)
  
  self:addAnimation("idle", {front = {3}, back = {1}, side = {2}}, 1)
  self.scale:set(0.5, 0.5)
  self.size = 0.4

  self:play("idle")
  self.hasShadow = false

end


function SampleCart:update(dt)
  SampleCart.super.update(self, dt)

  if self.railX then
    self.x = self.railX
  end
end
