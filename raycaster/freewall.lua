--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local FreeWall = Object:extend()

function FreeWall:new(x1,y1,x2,y2,u1,u2,image)
  self.x1 = x1
  self.y1 = y1
  self.x2 = x2
  self.y2 = y2
  self.u1 = u1 or 0
  self.u2 = u2 or 1
  self.image = image

  self.last = {
    x1 = x1, y1 = y1,
    x2 = x2, y2 = y2
  }
end


function FreeWall:testRay(sx, sy, rdx,rdy)
  local ix, iy = tools.ray_line_intersection(
      sx, sy, rdx, rdy, self.x1, self.y1, self.x2, self.y2)

  if ix and iy then
    return ix,iy
  end

  return nil
end


-- Always use this function to update wall position
function FreeWall:move(x1, y1, x2, y2)
  self.last.x1 = self.x1
  self.last.x2 = self.x2
  self.last.y1 = self.y1
  self.last.y2 = self.y2

  self.x1 = x1
  self.y1 = y1
  self.x2 = x2
  self.y2 = y2
end


return FreeWall
