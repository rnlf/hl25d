--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "item.battery"
require "item.firstaid"
require "item.glockclip"
require "item.hevsuit"
require "mob.barnacle"
require "mob.headcrab"
require "mob.scientist"
require "mob.barney"
require "crate"
require "player"
require "samplecart"

local util  = require 'util'

EntityFactory = Object:extend()

local function makeLoader(entityClass)
  return function(o)
    local e = entityClass()
    e:warp(o.x, o.y)
    util.applyProperties(e, o.properties)
    return e
  end
end


EntityFactory.entities = {
  crate           = makeLoader(Crate),
  battery         = makeLoader(Battery),
  firstaid        = makeLoader(FirstAid),
  glockclip       = makeLoader(GlockClip),
  headcrab        = makeLoader(Headcrab),
  barnacle        = makeLoader(Barnacle),
  scientist       = makeLoader(Scientist),
  barney          = makeLoader(Barney),
  hevsuit         = makeLoader(HEVSuit),
  samplecart      = makeLoader(SampleCart),
  player          =
    function(o)
      G.state.player:warp(o.x, o.y)
      util.applyProperties(G.state.player, o.properties)
    end
}


function EntityFactory.createEntity(o)
  local name = o.type
  local x = EntityFactory.entities[name]
  assert(x, "Bad entity type '" .. name .. "'")
  return x(o)
end


function EntityFactory.createEntities(mapdata, state)
  lume.trace("loading map objects")
  local tileset = mapdata.tilesets[1]
  local objlayer = lume.match(mapdata.layers,
                              lume.lambda "x->x.name=='entities'")

  lume.each(objlayer.objects, function(o)
              o.x = o.x / tileset.tilewidth
              o.y = o.y / tileset.tileheight
              o.width = o.width and o.width / tileset.tilewidth
              o.height = o.height and o.height / tileset.tileheight
            end)

  lume.each(objlayer.objects,
    function(o)
      local e = EntityFactory.createEntity(o)
      if e then state.world:add(e) end
    end)
end
