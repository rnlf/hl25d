--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
UsableTile = Object:extend()

function UsableTile:new(level, x, y)
  local gx, xd = math.modf(x)
  local gy, yd = math.modf(y)
  xd = xd - 0.5
  yd = yd - 0.5

  self.tileX = gx
  self.tileY = gy

  if math.abs(xd) > math.abs(yd) then
    if xd > 0 then
      self.face = 'right'
    else
      self.face = 'left'
    end
  else
    if yd > 0 then
      self.face = 'bottom'
    else
      self.face = 'top'
    end
  end

  local basetile = level.layers[self.face]:get(self.tileX, self.tileY)
  local tsw, _ = level:getTilesetSize()
  self.tiles = {
    basetile,
    basetile + tsw
  }

  self.level = level
end


function UsableTile:onUse(user)
  -- default does nothing
end


function UsableTile:alterWall(tileidx)
  self.level.layers[self.face]:set(self.tileX, self.tileY, self.tiles[tileidx])
end
