--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--


Vec3 = Object:extend()

Vec3.axes = { "x", "y", "z" }

function Vec3:new(x, y, z)
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
end


function Vec3:set(x, y, z)
  self.x = x or self.x
  self.y = y or self.y
  self.z = z or self.z
end


function Vec3:clone(dest)
  dest = dest or Vec3()
  dest.x = self.x
  dest.y = self.y
  dest.z = self.z
  return dest
end


function Vec3:magnitude()
  local x = self.x
  local y = self.y
  local z = self.z
  return math.sqrt(x*x + y*y + z*z)
end
