--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local Stripes = require 'raycaster.stripes'

local FloorCeilingRenderer = Object:extend()


-- fov in deg
function FloorCeilingRenderer:new(renderer, fov, viewport)
  fov = math.rad(fov)
  self.renderer = renderer
  self.viewport = viewport
  self.fov = {
    tanX2 = math.tan(fov/2),
  }

  self.distViewplane = 0.5 / self.fov.tanX2
  self.fov.tanY2   = 0.5 * viewport.y2 / (viewport.x2 * self.distViewplane)

  self.canvas = love.graphics.newCanvas(G.config.floorcanvassize, 
                                        G.config.floorcanvassize)
  self.canvas:setFilter('nearest', 'nearest')


  self.groundCeilingBatch = 
      love.graphics.newSpriteBatch(self.renderer.wallTexture, 256)

  self.quads = Stripes(0,0,G.config.floorcanvassize,G.config.floorcanvassize,
                           G.config.floorcanvassize,G.config.floorcanvassize)
end


-- Render given layer to screen with perspective
function FloorCeilingRenderer:render(sx,sy, dir,tiles, maxDist, 
                                     layer, offset, step, eyeWallDist)
  eyeWallDist = eyeWallDist or 0.5
  maxDist = math.min(maxDist, G.config.viewdist)
  love.graphics.setColor(255,255,255,255)
  self:prepareLayerBatch(sx,sy,tiles, layer, maxDist)

  -- this computes the distance of the bottom scanline 
  -- (1 == 100% of vertical fov)
  local lastDist = self:scanlineDist(1, eyeWallDist)
  local currentTiles = math.ceil(self:scanlineWidth(lastDist)) * 
                            G.config.floorquality
  local currentScale = self.canvas:getWidth() / 
                            (self.renderer.level.tilewidth * currentTiles)

  self:drawPerspectiveLayer(sx,sy,dir,self.canvas, layer,currentScale)

  for i = self.viewport.y2,2,-1 do
    local dist = self:scanlineDist(i/self.viewport.y2, eyeWallDist)
    local totalWidth = self:scanlineWidth(dist)

    -- need to go to the next scale level
    if totalWidth > currentTiles then
      -- finish current batch

      -- start next one
      currentTiles = currentTiles * 2
      currentScale = currentScale / 2

      self:drawPerspectiveLayer(sx,sy,dir,self.canvas, layer,currentScale)
    end

    local texU = math.floor((dist / currentTiles) * self.canvas:getWidth())
    local colSize = self.canvas:getHeight() * totalWidth / currentTiles

    local quad = self.quads:getStripe(texU)
    local renderData = {0.5*math.pi,
                        1, self.viewport.x / colSize, 
                        0.5, G.config.floorcanvassize / 2}

    love.graphics.drawq(self.canvas, quad, self.viewport.x2,
                        offset + step * i + 1, unpack(renderData))

    if dist > maxDist then return end
  end
end


-- Distance of a scanline offset pixels below (for floors) 
-- or above (for ceilings) the line between the central two
-- scanlines
function FloorCeilingRenderer:scanlineDist(offset, eyeWallDist)
  return eyeWallDist / (offset*self.fov.tanY2)
end


-- Prepare the sprite batch for the layer tiles, will be used
-- multiple times to draw different distance scale textures
function FloorCeilingRenderer:prepareLayerBatch(sx,sy,collect, layer, maxDist)
  local tw = self.renderer.level.tilewidth
  local th = self.renderer.level.tileheight
  self.groundCeilingBatch:bind()
  self.groundCeilingBatch:clear()
  local sqrt05 = math.sqrt(0.5)
  local ldist = maxDist + sqrt05
  ldist = ldist * ldist
  local lw = self.renderer.level.width
  for ti,_ in pairs(collect.tiles) do
    local col = ti % lw
    local row = math.floor(ti / lw)
    local dx = sx - (col+0.5)
    local dy = sy - (row+0.5)
    local d = dx*dx+dy*dy
    if dx*dx+dy*dy <= ldist then
      local tile = self.renderer.fullTiles[layer:get(col, row)]
      if tile then
        self.groundCeilingBatch:addq(
                      tile,
                      col*tw,
                      -row*th,
                      0,
                      1,
                      -1)
      end
    end
  end
  self.groundCeilingBatch:unbind()
end


-- how many tiles fit into one scanline at the given distance
function FloorCeilingRenderer:scanlineWidth(dist)
  return 2 * dist * self.fov.tanX2
end


-- draw layer (floor or ceiling) from the viewpoint of the player
function FloorCeilingRenderer:drawPerspectiveLayer(sx,sy,dir,image,layer, -- TODO layer is superfluous
                                                   floorTileScale)
  local oldCanvas = love.graphics.getCanvas()
  local tw = self.renderer.level.tilewidth
  local th = self.renderer.level.tileheight
  love.graphics.setCanvas(image)
  love.graphics.push()
  love.graphics.translate(0,image:getHeight() / 2)
  love.graphics.rotate(dir)
  love.graphics.scale(floorTileScale, floorTileScale)
  love.graphics.translate(-sx*tw,sy*th)
  love.graphics.setColor(255,255,255,255)

  love.graphics.draw(self.groundCeilingBatch)

  love.graphics.pop()
  love.graphics.setCanvas(oldCanvas)
end


return FloorCeilingRenderer
