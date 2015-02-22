--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'usable.button'
require 'usable.firstaidstation'
require 'usable.rechargestation'

local util = require 'util'

UsableTileFactory = Object:extend()

local function makeLoader(objectClass)
  return function(level, o)
    local tile = objectClass(level, o.x, o.y)
    util.applyProperties(tile, o.properties)
    return tile
  end
end


UsableTileFactory.tiles = {
  button = makeLoader(Button),
  firstaid = makeLoader(FirstAidStation),
  recharger = makeLoader(RechargeStation)
}


function UsableTileFactory.createUsableTile(level, o) 
  local name = o.type
  local x = UsableTileFactory.tiles[name]
  assert(x, "Bad usable tile type '" .. name .. "'")
  return x(level, o)
end


function UsableTileFactory.createUsableTiles(layer, level)
  lume.trace("loading usable tiles")

  lume.each(layer.objects, function(o)
              o.x = o.x / level.tilewidth
              o.y = o.y / level.tileheight
              level:addUsableTile(UsableTileFactory.createUsableTile(level, o))
            end)
end
