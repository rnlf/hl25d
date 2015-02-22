--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local VisitedTiles = Object:extend()

function VisitedTiles:new(mapWidth)
  self.mw = mapWidth
  self.tiles = {}
end

function VisitedTiles:insert(x,y)
  self.tiles[y*self.mw + x] = true
end

return VisitedTiles
