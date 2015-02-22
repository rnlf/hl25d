--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local Stripes = require('raycaster.stripes')
local StripedImage = require('raycaster.stripedimage')
local VisitedTiles = require('raycaster.visitedtiles')
local FloorCeilingRenderer = require 'raycaster.floorceilingrenderer'

require('vec3')

local Renderer = Object:extend()
Renderer.minViewDist = 0.00000001


local function compareDist(a,b)
  return a.dist > b.dist
end


function Renderer:new(level, fov, viewportX, viewportY)
  self.viewport = {x = viewportX or 320, 
                   y = viewportY or 240}
  self.viewport.x2 = self.viewport.x / 2
  self.viewport.y2 = self.viewport.y / 2

  self.level = level
  self.fov = math.rad(fov or 60)
  self.tanFov2 = math.tan(self.fov/2)
  self.normalizedDistFromProjPlane = 1 / self.tanFov2
  self.distanceFromProjPlane = self.viewport.x2 *
    self.normalizedDistFromProjPlane
  self.tanVertFov2 = self.viewport.y2 / self.distanceFromProjPlane
  self.vertFov = 2 * math.atan(self.tanVertFov2)


  self.shadowSprite = love.graphics.newImage('data/image/shadow.png')
  self.shadowSprite:setFilter('nearest', 'nearest')

  local image = level.mapdata.tilesets[1].image:gsub("%.%.", "data")
  self.wallTexture = love.graphics.newImage(image)
  self.wallTexture:setFilter('nearest', 'nearest')

  self.tiles = {}
  self.fullTiles = {}
  local tw = level.tilewidth
  local th = level.tileheight
  local iw = level.imagewidth
  local ih = level.imageheight
  for row = 0, ih / th  - 1 do
    for col = 0, iw / tw - 1 do
      self.tiles[#self.tiles+1] = raycaster.StripedImage(
        self.wallTexture, col*tw, row*th, tw, th
      )
      self.fullTiles[#self.fullTiles+1] = love.graphics.newQuad(
        col*tw, row*th, tw, th, iw, ih
      )
    end
  end

  self.spriteBatch = love.graphics.newSpriteBatch(
    self.wallTexture, self.viewport.x
  )
  self.floorCeiling = FloorCeilingRenderer(self, fov, self.viewport)
end

-- Cast one ray per screen column
function Renderer:computeColumns(sx, sy, dx, dy, collect)
  local nx,ny = tools.normal(tools.normalize(dx,dy))

  local columns = {}
  local colF = self.tanFov2 / self.viewport.x2
  local colFx = colF * nx
  local colFy = colF * ny

  local viewdist = G.config.viewdist

  local maxDist = 0
  local tw = self.level.tilewidth
  local tm = self.level.tilemap

  for j = 0, self.viewport.x - 1 do
    local rayOffset = j - self.viewport.x2
    local rayDx = dx - rayOffset * colFx
    local rayDy = dy - rayOffset * colFy

    local column = tm:cast(sx, sy, rayDx, rayDy, collect)
    
    local tileIdx = self.level.layers[column.face]:get(column.mapX,
                                                column.mapY)
    local tile = self.tiles[tileIdx]

    -- correct tilewidth
    column.stripe = tile:getStripe(math.min(tw, math.floor(column.texU*tw)))
    column.texture = self.wallTexture

    if column.dist <= viewdist then 
      column.column = j
      table.insert(columns, column)
    end
    maxDist = math.max(maxDist, column.dist)
  end

  return columns, maxDist
end

-- Draws all columns that are farther away than minDist, starting with
-- column firstIdx
function Renderer:drawWallColumns(columns, firstIdx, minDist, eyeHeight)

  self.spriteBatch:bind()
  self.spriteBatch:clear()

  local th = self.level.tileheight
  while firstIdx <= #columns and columns[firstIdx].dist > minDist do
    local c = columns[firstIdx]
    local h = self:scaleFactorAtDistance(c.dist)
    local sh = 1/th * h
    self.spriteBatch:addq(c.stripe, c.column, self.viewport.y2 + (eyeHeight-0.5) *
      self:scaleFactorAtDistance(c.dist), 0, 1, sh, 0, th/2)
    firstIdx = firstIdx + 1
  end
  self.spriteBatch:unbind() 

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(self.spriteBatch)

  return firstIdx
end

-- Draws all sprites from farthest to closest. Calls drawWallColumns
-- for columns between the sprites
function Renderer:drawSprites(sx, sy, dx, dy, columnData, sprites, eyeHeight)
  local columnIdx = 1
  for i,sprite in pairs(sprites) do

    -- draw wall columns farther away than current sprite
    columnIdx = self:drawWallColumns(
      columnData, columnIdx, sprite.dist, eyeHeight
    )

    local x,y,w,h = sprite.quad:getViewport()

    -- Draw shadow first
    if sprite.entity and sprite.entity.hasShadow then
      love.graphics.setColor(
        255, 255, 255, sprite.alpha * 192 * math.max(0.3,(1-2*sprite.z))
      )
      local shadowScale = self:scaleFactorAtDistance(sprite.dist)
      local shadowFact = sprite.entity.size * shadowScale *
        (1+sprite.z) / self.shadowSprite:getWidth()

      love.graphics.draw(
        self.shadowSprite,
        sprite.x,
        self.viewport.y2 + eyeHeight * shadowScale,
        0,
        shadowFact,
        shadowFact,
        self.shadowSprite:getWidth() / 2,
        self.shadowSprite:getHeight() / 2
      )
    end

    -- Then sprite
    love.graphics.setColor(255, 255, 255, sprite.alpha * 255)
    love.graphics.drawq(
      sprite.texture,
      sprite.quad,
      sprite.x,
      sprite.y,
      sprite.rotation,
      sprite.scale.x,
      sprite.scale.y,
      sprite.origin.x,
      sprite.origin.y)
  end
  -- draw rest of columns
  self:drawWallColumns(columnData, columnIdx, self.minViewDist, eyeHeight)
end

function Renderer:collectSprite(sx, sy, dx, dy, entities, 
                                maxDist, eyeHeight, sprites)
  local camAngle = math.atan2(dy, dx)
  local nx,ny = tools.normal(tools.normalize(dx, dy))
  local qx = sx + dx
  local qy = sy + dy
  for i,e in ipairs(entities) do
    e.wasVisible = false
    if e.image then 
      local rsx = e.x-sx
      local rsy = e.y-sy

      local lx,ly = tools.ray_ray_intersection(qx, qy, nx, ny, sx,
                                               sy, rsx, rsy)
      -- else the sprite is directly left or right of the player
      if lx and ly then 
        local loff = (qx-lx) *nx + (qy-ly) * ny
        local centerCol = (loff / self.tanFov2 + 1) * self.viewport.x2

        local distSq = rsx*rsx + rsy*rsy

        -- rule out sprites that are too close or farther away than the
        -- farthest wall column
        if distSq < maxDist*maxDist and rsx*dx+rsy*dy > self.minViewDist then
          local angle = math.atan2(rsy,rsx) - camAngle
          local dist = math.sqrt(distSq) * math.abs(math.cos(angle))
          local scale = self:scaleFactorAtDistance(dist)

          -- very rough estimate, but easy to compute
          if math.abs(centerCol - self.viewport.x2) <= 
              self.viewport.x2 + scale * e.size then
            local incidentAngle
            if math.abs(rsx) > math.abs(rsy) then
              if rsx > 0 then
                incidentAngle = math.pi
              else
                incidentAngle = 0
              end
            else
              if rsy > 0 then
                incidentAngle = 0.5 * math.pi
              else
                incidentAngle = 1.5 * math.pi
              end
            end
            incidentAngle = incidentAngle + e.facing
            while  incidentAngle > 2 * math.pi do
              incidentAngle = incidentAngle - 2 * math.pi
            end

            while  incidentAngle < 0 do
              incidentAngle = incidentAngle + 2 * math.pi
            end


            local quad = e:getQuad(incidentAngle)
            local qx,qy,qw,qh = quad:getViewport()

            sprites[#sprites+1] = {
                dist     = dist,
                texture  = e.image,
                quad     = quad,
                scale    = Vec3(scale * e.scale.x / qh, 
                                scale * e.scale.y / qh),
                rotation = math.rad(e.angle),
                origin   = e.origin,
                alpha    = e.alpha,
                x        = centerCol,
                y        = self.viewport.y2 - (e.z-eyeHeight) * scale,
                z        = e.z,
                entity   = e
              }
            e.wasVisible = true
          end
        end
      end
    end
  end
end


function Renderer:findFreewalls(sx, sy, dx, dy, collect,
                                columns, sprites, eyeHeight)
  local dx0, dy0 = tools.normalize(dx,dy)
  local nx,ny = tools.normal(dx0, dy0)
  local qx,qy = sx+dx, sy+dy

  local colF = self.tanFov2 / self.viewport.x2
  local colFx = colF * nx
  local colFy = colF * ny

  local camAngle = math.atan2(dy, dx)

  local freeWalls = self.level.freewalls:getPossibleFreewalls(collect)
  
  local rx = self.tanFov2
  



  for fw,_ in pairs(freeWalls) do
    local wx1, wy1 = tools.rotate(fw.x1 - sx, fw.y1 - sy, -camAngle)
    local wx2, wy2 = tools.rotate(fw.x2 - sx, fw.y2 - sy, -camAngle)

    wx1, wy1, wx2, wy2 = tools.clip_line(wx1, wy1, wx2, wy2, 0, 0, rx, 1)

    if wx1 then
      wx1, wy1, wx2, wy2 = tools.clip_line(wx1, wy1, wx2, wy2, 0, 0, rx, -1)

      if wx1 then
        local a1 = math.atan2(wy1, wx1)
        local a2 = math.atan2(wy2, wx2)

        local b1 = a1 / colF * 1.12
        local b2 = a2 / colF * 1.12

        local d1, d2 = math.min(b1, b2), math.max(b1, b2)

        -- FIXME not too sure why -10 and +10 are required, if everything were
        -- mathematically sane, then -1 and +1 should be correct, but then some columns
        -- are left out sometimes :-(
        local c1 = math.max(0, math.floor((self.viewport.x2 + d1 - 10)))
        local c2 = math.min(self.viewport.x, math.ceil((self.viewport.x2 + d2 + 10)))

        for checkCol = c1, c2 do
          local ro = -checkCol + self.viewport.x2
          local rdx = dx + ro * colFx
          local rdy = dy + ro * colFy

          local ix, iy = fw:testRay(sx, sy, rdx, rdy)

          if ix then
            local rx = ix - sx
            local ry = iy - sy
            local angle = math.atan2(ry,rx) - camAngle
            local dist = tools.length(rx,ry) * math.abs(math.cos(angle))
            if not columns[checkCol+1] or dist < columns[checkCol+1].dist then
              local texU = tools.length(ix-fw.x1,iy-fw.y1) /
                tools.length(fw.x1 - fw.x2, fw.y1 - fw.y2)

              texU = math.floor((fw.u1 + (fw.u2-fw.u1) * texU) * #fw.image.stripes) % #fw.image.stripes

              local quad = fw.image:getStripe(texU)
              local qx,qy,qw,qh = quad:getViewport()
              local scale = self:scaleFactorAtDistance(dist)
              table.insert(sprites,
                {
                  dist = dist,
                  quad = quad,
                  texture = fw.image.image,
                  scale = Vec3(1, scale / qh),
                  origin = Vec3(0, 0),
                  alpha = 1,
                  x = checkCol,
                  y = self.viewport.y2 - (1-eyeHeight) * scale,
                  z = 0,
                  entity = nil
                })
            end
          end
        end
      end
    end
  end
end

function Renderer:draw(sx,sy,dx,dy,entities,eyeHeight)


  -- Find columns and sprites, sorted by depth
  local collect = VisitedTiles(self.level.width)
  local columns, maxDist = self:computeColumns(sx, sy, dx, dy, collect)
  local sprites = {}
  self:findFreewalls(sx, sy, dx, dy, collect, columns, sprites, eyeHeight)
  self:collectSprite(sx, sy, dx, dy, entities,
                     math.min(maxDist, G.config.viewdist), eyeHeight, sprites)

  table.sort(columns, compareDist)
  table.sort(sprites, compareDist)

  self.floorCeiling:render(sx, sy, math.atan2(dy, dx), collect, maxDist,
    self.level.layers.floor, self.viewport.y2-1, 1, eyeHeight)
  self.floorCeiling:render(sx, sy, math.atan2(dy, dx), collect, maxDist,
    self.level.layers.ceiling, self.viewport.y2, -1, 1-eyeHeight)

  self:drawSprites(sx, sy, dx, dy, columns, sprites, eyeHeight)
end


function Renderer:scaleFactorAtDistance(dist)
  return self.distanceFromProjPlane / dist 
end


return Renderer
