--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local StripedImage = require 'raycaster.stripedimage'
local FreeWall = require 'raycaster.freewall'
local VisitedTiles = require 'raycaster.visitedtiles'

FreeWallLayer = Object:extend()
FreeWallLayer.wallDepth = 0

function FreeWallLayer:new(level, layer)
  self.level = level
  self.freeWalls = {}
  self.freeWallNames = {}
end


function FreeWallLayer:collideEntity(entity)
  local movementX = entity.x - entity.last.x
  local movementY = entity.y - entity.last.y

  -- Add margin around hull. This way, walls which would
  -- usually only be checked in the next frame can be considered
  -- potential colliders. Without this, the detection would not
  -- be detected before the next frame (after entity has temporarily
  -- passed through the wall, which would suck).
  local scaledMovementX, scaledMovementY = tools.scale(
    movementX,
    movementY,
    entity.size + entity.velocity:magnitude()
  )

  local normX, normY = tools.normal(scaledMovementX, scaledMovementY)

  local collect = VisitedTiles(self.level.width)

  -- Assumption: Entities are never larger than 3 tiles, get possible tiles
  -- by casting three rays: one on the left of the entities ground track, one
  -- on the right, and one from back to front

  self.level.tilemap:trace(entity.last.x - scaledMovementX,
                           entity.last.y - scaledMovementY,
                           entity.x + scaledMovementX,
                           entity.y + scaledMovementY,
                           collect)

  self.level.tilemap:trace(entity.last.x + normX,
                           entity.last.y + normY,
                           entity.x + normX,
                           entity.y + normY,
                           collect)

  self.level.tilemap:trace(entity.last.x - normX,
                           entity.last.y - normY,
                           entity.x - normX,
                           entity.y - normY,
                           collect)

  local possibleWalls = self:getPossibleFreewalls(collect)

  for w,_ in pairs(possibleWalls) do

    self:collideEntityWall(entity, w)
  end

end


function FreeWallLayer:lineOfSight(a, b)
  local rx, ry = b.x - a.x, b.y - a.y

  local collect = VisitedTiles(self.level.width)
  self.level.tilemap:trace(a.x, a.y, b.x, b.y, collect, true)

  local possibleWalls = self:getPossibleFreewalls(collect)
  for w,_ in pairs(possibleWalls) do
    local ix, iy = w:testRay(a.x, a.y, rx, ry)

    if ix then
      local dx, dy = ix - a.x, iy - a.y
      -- Make sure the intersection is actually between the two entities.
      -- The hitpoint might be behind the second entity in the same tile.
      local dotp = dx * rx + dy * ry
      if dotp > 0 and dotp <= rx*rx+ry*ry then
        return false
      end
    end
  end

  return true
end


function FreeWallLayer:collideEntityWall(entity, wall)
  local pivotX, pivotY = tools.point_line_pivot(entity.x, entity.y,
    wall.x1, wall.y1,
    wall.x2, wall.y2)

  local dx,dy = pivotX - entity.x, pivotY - entity.y
  local distsq = dx*dx+dy*dy
  local mindist = entity.size + self.wallDepth

  if distsq < mindist*mindist then
    local sx, sy = tools.scale(dx, dy, mindist)
    entity:warp(pivotX - sx, pivotY - sy)
  end
end


function FreeWallLayer:collideGroup(group)
  local members = group.members
  for i = 1, #group.members do
    self:collideEntity(members[i])
  end
end


function FreeWallLayer:getPossibleFreewalls(collect)
  local freeWalls = self.freeWalls
  local possibleFreeWalls = {}

  for tidx, _ in pairs(collect.tiles) do
    local fws = freeWalls[tidx]
    if fws then
      for fw,_ in pairs(fws) do
        possibleFreeWalls[fw] = fw
      end
    end
  end

  return possibleFreeWalls
end


function FreeWallLayer:removeFreeWall(wall)
  if wall.touchedTiles then
    for _,k in ipairs(wall.touchedTiles) do
      if self.freeWalls[k] then
        self.freeWalls[k][wall] = nil
      end
    end
  end

  wall.touchedTiles = {}

  if wall.name then
    self.freeWallNames[wall.name] = nil
  end
end


function FreeWallLayer:addFreeWall(wall)

  self:removeFreeWall(wall)

  local collect = VisitedTiles(self.level.width)
  self.level.tilemap:trace(wall.x1,wall.y1,wall.x2,wall.y2,collect)


  wall.touchedTiles = {}
  for k,_ in pairs(collect.tiles) do
    table.insert(wall.touchedTiles, k)
    if not self.freeWalls[k] then
      self.freeWalls[k] = {}
    end

    self.freeWalls[k][wall] = wall
  end

  if wall.name then
    self.freeWallNames[wall.name] = wall
  end
end


function FreeWallLayer:getFreeWall(name)
  return self.freeWallNames[name]
end


function FreeWallLayer:readFreeWalls(l)
  for _,o in ipairs(l.objects) do
    if o.polyline and o.properties.texture then
      -- TODO Loading of the image and creating the stripe quads
      --      should actually be done in the renderer
      local image = StripedImage(G.imageCache:load(o.properties.texture))
      local tilewidth = self.level.tilewidth
      local tileheight = self.level.tileheight

      local wall = FreeWall((o.polyline[1].x+o.x)/tilewidth,
                            (o.polyline[1].y+o.y)/tileheight,
                            (o.polyline[2].x+o.x)/tilewidth,
                            (o.polyline[2].y+o.y)/tileheight,
                            tonumber(o.properties.u1), tonumber(o.properties.u2), image)

      if o.name ~= "" then
        wall.name = o.name
      end
      self:addFreeWall(wall)
    end
  end
end


