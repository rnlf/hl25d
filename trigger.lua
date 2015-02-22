--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
Trigger = Object:extend()

function Trigger:new(level, polygon)
  assert(#polygon >= 3, "Polygon trigger area needs at least 3 points")
  self.polygon = polygon
  self:computeBB()
  self.onActivate = ''
  self.onDeactivate = ''
  self.level = level
end


function Trigger:computeBB()
  self.xmin = self.polygon[1][1]
  self.xmax = self.xmin
  self.ymin = self.polygon[1][2]
  self.ymax = self.ymin

  for i = 2, #self.polygon do
    self.xmin = math.min(self.polygon[i][1], self.xmin)
    self.xmax = math.max(self.polygon[i][1], self.xmax)
    self.ymin = math.min(self.polygon[i][2], self.ymin)
    self.ymax = math.max(self.polygon[i][2], self.ymax)
  end
end


function Trigger:test(x,y)
  -- this assumes a pre-check (using the bounding box) has already
  -- been peformed

  return tools.point_in_polygon(x,y,self.polygon)
end


function Trigger:activate()
  local activateFn = self.level:getLevelVar(self.onActivate)
  if activateFn then
    activateFn(self)
  end
end


function Trigger:deactivate()
  local deactivateFn = self.level:getLevelVar(self.onDeactivate)
  if deactivateFn then
    deactivateFn(self)
  end
end
