--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local FreeWall = require('raycaster.freewall')
local StripedImage = require('raycaster.stripedimage')
local VisitedTiles = require 'raycaster.visitedtiles'
require 'tilelayer'
require 'tilemap'
require 'freewalllayer'
require 'usabletilefactory'
require 'triggerlayer'

Level = Object:extend()


function Level:new(levelname)
  self.timer = Timer()
  lume.trace("Loading level:", levelname)
  self.descriptor = dofile("data/level/" .. levelname .. ".lua")
  local mapname = self.descriptor.map
  lume.trace("Loading map:", mapname)
  self.mapdata = dofile("data/map/" .. mapname .. ".lua")

  self.tilewidth = self.mapdata.tilesets[1].tilewidth
  self.tileheight = self.mapdata.tilesets[1].tileheight
  self.imagewidth = self.mapdata.tilesets[1].imagewidth
  self.imageheight = self.mapdata.tilesets[1].imageheight

  self.usabletiles = {}

  self.layers = {}
  local freewallLayer, usableTileLayer, triggersLayer

  for i,l in ipairs(self.mapdata.layers) do
    if l.type == 'tilelayer' then
      self.layers[l.name] = TileLayer(l)
    end

    if l.name == 'freewalls' then
      freewallLayer = l
    elseif l.name == 'usabletiles' then
      usableTileLayer = l
    elseif l.name == 'triggers' then
      triggersLayer = l
    end
  end

  assert(self.layers.walls,   "Layer 'walls' must be present in map")
  assert(self.layers.floor,   "Layer 'floor' must be present in map")
  assert(self.layers.ceiling, "Layer 'ceiling' must be present in map")

  local mergeLayer = function(layername)
    local layer = self.layers[layername]

    if layer then
      local wallsData = self.layers.walls.data
      local data = layer.data
      for i = 1, #data do
        if data[i] == 0 then
          data[i] = wallsData[i]
        end
      end
    else
      self.layers[layername] = self.layers.walls
    end
  end

  mergeLayer('bottom')
  mergeLayer('top')
  mergeLayer('left')
  mergeLayer('right')

  self.tilemap = TileMap(self.layers.walls)

  self.width = self.mapdata.width
  self.height = self.mapdata.height

  self.freewalls = FreeWallLayer(self)
  if freewallLayer then
    self.freewalls:readFreeWalls(freewallLayer)
  end

  if usableTileLayer then
    self:readUsableTiles(usableTileLayer)
  end

  self.triggers = TriggerLayer(self)
  if triggersLayer then
    self.triggers:readTriggers(triggersLayer)
  end
end


function Level:canSpawn(entity)
  -- TODO Check other colliders (FreeWalls) or ignore freewalls and let
  --      collision handling clean up the mess?
  return not self.tilemap:overlapsEntity(entity)
end


function Level:lineOfSight(a,b)
  return self.tilemap:lineOfSight(a,b) and self.freewalls:lineOfSight(a,b)
end


function Level:getTilesetSize()
  -- TODO make sure to use the same data for the raycaster as
  --      for all other parts on the software and then use
  --      a member function of Level to do this
  local tileset = self.mapdata.tilesets[1]
  return tileset.imagewidth / tileset.tilewidth,
         tileset.imageheight / tileset.tileheight
end


-- Cast a ray through the level. This checks walls, entities and freewalls
-- for collision and returns the closest object
function Level:castRay(sx,sy,angle,maxDist,filter)

  filter = filter or function() return true end
  local nearestEntity = nil
  local nearestDist = math.huge
  local cosa = math.cos(angle)
  local sina = math.sin(angle)

-- find closest sprite for given ray
  for i,e in ipairs(G.state.world.members) do
    if filter(e) then
      local dx = e.x - sx
      local dy = e.y - sy
      local nx1, ny1 = tools.normal(dx,dy)
      local nx, ny = tools.scale(nx1, ny1, e.size)
      local p1x = e.x + nx
      local p1y = e.y + ny
      local p2x = e.x - nx
      local p2y = e.y - ny

      local ix,iy = tools.ray_line_intersection(
                              sx,sy,
                              cosa, sina,
                              p1x, p1y, p2x, p2y)

      if ix and iy then
        local tx,ty = ix-sx,iy-sy
        local dist = tx*tx+ty*ty
        if dist < nearestDist then
          nearestDist = dist
          nearestEntity = e
        end
      end
    end
  end

  local collect = VisitedTiles(self.width)
  -- TODO: This looks wrong
  local wallHit = self.tilemap:cast(sx,sy,cosa,sina, collect)

  local freeWalls = self.freewalls:getPossibleFreewalls(collect)
  for _, wall in pairs(freeWalls) do
    local ix,iy = wall:testRay(sx, sy, cosa, sina)
    if ix and iy then
      local dsq = tools.sq(ix-sx) + tools.sq(iy-sy)
      if wallHit.dist*wallHit.dist > dsq then
        wallHit = {
          dist = math.sqrt(dsq),
          ix = ix,
          iy = iy }
      end
    end
  end

  -- nothing in range
  if maxDist and wallHit.dist > maxDist and nearestDist > maxDist then
    return {type = 'nothing'}
  end

  -- Also true if no entity was hit
  if wallHit.dist*wallHit.dist < nearestDist then
    return {type = 'wall', wall = wallHit}
  end

  return {type = 'entity', entity = nearestEntity}
end


function Level:collideGroup(group)
  -- TODO add other potential colliders (free walls)
  self.tilemap:collideGroup(group)
  self.freewalls:collideGroup(group)
end


function Level.closestWall(x, y)
  local _1, xd = math.modf(x)
  local _2, yd = math.modf(y)
  xd = xd - 0.5
  yd = yd - 0.5

  local face
  local tx,ty = 0,0
  if math.abs(xd) > math.abs(yd) then
    if xd > 0 then
      face = 'left'
      tx = 1
    else
      face = 'right'
      tx = -1
    end
  else
    if yd > 0 then
      face = 'top'
      ty = 1
    else
      face = 'bottom'
      ty = -1
    end
  end

  tx = tx + math.floor(x)
  ty = ty + math.floor(y)

  return tx, ty, face
end


function Level:getUsableTile(x,y,face)
  local idx = x + y * self.width
  
  local tile = self.usabletiles[idx]
  if not tile then return nil end

  -- may be nil
  return tile[face]
end


function Level:addUsableTile(tile)
  local idx = tile.tileX + tile.tileY * self.width

  if not self.usabletiles[idx] then
    self.usabletiles[idx] = {}
  end

  self.usabletiles[idx][tile.face] = tile
end


function Level:readUsableTiles(usableTileLayer)
  UsableTileFactory.createUsableTiles(usableTileLayer, self)
end


function Level:update(dt)
  self.timer:update(dt)
end


function Level:getLevelVar(name)
  return tools.scoped_get(self.descriptor.data, name)
end


function Level:init()
  if self.descriptor.data.init then
    self.descriptor.data.init()
  end
end
