--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
TileLayer = Object:extend()

function TileLayer:new(layerdata)
  self.data   = layerdata.data
  self.width  = layerdata.width
  self.height = layerdata.height
end


function TileLayer:get(x, y)
  return self.data[x+y*self.width + 1]
end


function TileLayer:set(x, y, tileid)
  self.data[x+y*self.width + 1] = tileid
end
