--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
-- The tilemap entity. This is only really used for world collision. Handles
-- the loading a .lua map exported from tiled.

TileMap = Object:extend()


function TileMap:new(layer)
  self.layer = layer
end


function TileMap:iterrect(x, y, width, height)
  return coroutine.wrap(
    function()
      local layer = self.layer
      for y = math.floor(y), math.ceil(y + height) do
        for x = math.floor(x), math.ceil(x + width) do
          coroutine.yield(x, y, layer:get(x, y))
        end
      end
    end)
end


function TileMap:iterline(x1, y1, x2, y2)
  x1, x2 = lume.round(x1), lume.round(x2)
  y1, y2 = lume.round(y1), lume.round(y2)
  if x1 == x2 and y1 == y2 then
    return lume.once(function() return x1, y1 end)
  end
  return coroutine.wrap(function()
    local minstep = 1 / math.max(math.abs(x2 - x1), math.abs(y2 - y1))
    local stepx = (x2 - x1) * minstep
    local stepy = (y2 - y1) * minstep
    local lastx, lasty
    repeat 
      x1 = x1 + stepx
      y1 = y1 + stepy
      local x, y = lume.round(x1), lume.round(y1)
      if x ~= lastx or y ~= lasty then
        coroutine.yield(x, y, self.layer:get(x, y))
        lastx, lasty = x, y
      end
    until x1 == x2
  end)
end


function TileMap:lineOfSight(e1, e2)
  for x, y, t in self:iterline(e1.x, e1.y, e2.x, e2.y) do
    if t ~= 0 then return false end
  end
  return true
end


function TileMap:overlapsEntity(e)
  local ex, ey, ew, eh = e:aabb()
  for x, y, t in self:iterrect(ex, ey, ew, eh) do
    if t ~= 0 and ey < y + 1 and ey + eh > y and ex < x + 1 and ex + ew > x
    then
      return true
    end
  end
  return false
end


function TileMap:collideEntity(e, depth)
  -- Quick fix: Detect if we end up in an infinite loop
  depth = depth or 0
  if depth > 10 then
    lume.trace(lume.format(
               "Hit collision recursion limit for entity at {x},{y}", e))
    return
  end
  -- Do collision
  if e.noWallCollisions then return end
  local ex, ey, ew, eh = e:aabb()
  local lx, ly = ex + (e.last.x - e.x), ey + (e.last.y - e.y)
  local sz = e.size + 10e-8
  -- X axis
  for x, y, t in self:iterrect(ex, ey, ew, eh) do
    if t ~= 0 and (ly < y + 1 and ly + eh > y) and ex < x + 1 and ex + ew > x 
    then
      e.x = e.x < x + .5 and x - sz or x + 1 + sz
      e.velocity.x = e.velocity.x * -e.bounce
      return self:collideEntity(e, depth + 1)
    end
  end
  -- Y axis
  for x, y, t in self:iterrect(ex, ey, ew, eh) do
    if t ~= 0 and ey < y + 1 and ey + eh > y and ex < x + 1 and ex + ew > x
    then
      e.y = e.y < y + .5 and y - sz or y + 1 + sz
      e.velocity.y = e.velocity.y * -e.bounce
      return self:collideEntity(e, depth + 1)
    end
  end
end


function TileMap:trace(sx,sy,ex,ey,collect,checkhit)
  local mapX = math.floor(sx)
  local mapY = math.floor(sy)
  local dx = ex - sx
  local dy = ey - sy

  local deltaDistX = math.sqrt(1 + tools.sq(dy) / tools.sq(dx))
  local deltaDistY = math.sqrt(1 + tools.sq(dx) / tools.sq(dy))
  local stepX
  local stepY
  local hit = false
  local side
  local sideDistX, sideDistY

  if dx < 0 then
    stepX = -1
    sideDistX = (sx - mapX) * deltaDistX
  else
    stepX = 1
    sideDistX = (mapX + 1.0 - sx) * deltaDistX
  end

  if dy < 0 then
    stepY = -1
    sideDistY = (sy - mapY) * deltaDistY
  else
    stepY = 1
    sideDistY = (mapY + 1.0 - sy) * deltaDistY
  end

  if collect then
    collect:insert(mapX, mapY)
  end

  local mapLastX = math.floor(ex)
  local mapLastY = math.floor(ey)
  local walls = self.layer
  while (mapLastY ~= mapY or mapLastX ~= mapX) 
        and not hit do
    if sideDistX < sideDistY then
      sideDistX = sideDistX + deltaDistX
      mapX = mapX + stepX
      side = 0
    else
      sideDistY = sideDistY + deltaDistY
      mapY = mapY + stepY
      side = 1
    end
    if collect then
      collect:insert(mapX, mapY)
    end

    if checkhit and walls:get(mapX, mapY) > 0 then
      hit = 1
    end
  end

  return mapX, mapY, side, stepX, stepY
end


function TileMap:collideGroup(g, solidonly)
  for _, e in pairs(g.members) do
    if not solidonly or e.solid then
      self:collideEntity(e)
    end
  end
end


function TileMap:cast(sx,sy,dx,dy,collect)
  local mapX, mapY, side, stepX, stepY = 
    self:trace(sx,sy,sx+10000*dx,sy+10000*dy,collect,true)
  
  local texU
  if side == 1 then
    texU = sx + ((mapY - sy + (1 - stepY) / 2) / dy) * dx
  else
    texU = sy + ((mapX - sx + (1 - stepX) / 2) / dx) * dy
  end

  texU = texU - math.floor(texU)

  local face

  local dist
  if side == 0 then
    dist = math.abs((mapX - sx + (1-stepX) / 2) / dx)
    if stepX > 0 then
      face = 'left'
    else
      face = 'right'
    end

  else
    dist = math.abs((mapY - sy + (1-stepY) / 2) / dy)
    if stepY > 0 then
      face = 'top'
    else
      face = 'bottom'
    end

  end


  local isx, isy = tools.scale(dx,dy,dist)
  isx = isx + sx
  isy = isy + sy

  return {
    dist = dist,
    ix = isx,
    iy = isy,
    texU = texU,
    mapX = mapX,
    mapY = mapY,
    face = face
  }
end
