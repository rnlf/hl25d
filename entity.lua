--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "vec3"
require "timer"

-- Something which can exist in the game world.. or outside of it.. within the
-- realms of it? Maybe a sprite but not always but probable.

Entity = Vec3:extend()


function Entity:new()
  Entity.super.new(self)
  self.velocity = Vec3()
  self.accel = Vec3()
  self.last = Vec3()
  self.timer = Timer()
  self.maxVelocity = math.huge
  self.drag = 0
  self.bounce = 0
  self.size = .3
  self.facing = 0
  -- Flags
  self.dead = false
  self.solid = true
  -- Graphics / animation
  self.alpha = 1
  self.image = nil
  self.angle = 0
  self.angularVelocity = 0
  self.scale = Vec3(1, 1)
  self.origin = Vec3()
  self.frameSize = { width = 0, height = 0 }
  self.frames = {}
  self.animations = {}
  self.animation = nil
  self.animationTimer = 0
  self.height = 0 -- at the moment only used by barnacles
  self:setFrame(1)

  self.hasShadow = true
  self.tween = flux.group()
end


function Entity:drawTo(fn)
  local canvasOld = love.graphics.getCanvas()
  love.graphics.reset()
  love.graphics.setCanvas(self.image)
  fn()
  love.graphics.setCanvas(canvasOld)
end


function Entity:makeImage(width, height, color)
  self.image = love.graphics.newCanvas(width, height)
  self.image:setFilter("nearest", "nearest")
  self.width = width
  self.height = height
  self.frameSize.width = width
  self.frameSize.height = height
  self.frames = {love.graphics.newQuad(0, 0, width, height, width, height)}
  if color then
    self.image:clear(lume.rgba(color))
  end
end


function Entity:loadImage(image, width, height)
  self.image = G.imageCache:load(image)
  width = width or self.image:getWidth()
  height = height or self.image:getHeight()
  self.frameSize.width = width
  self.frameSize.height = height
  self.frames = {}
  for y = 0, self.image:getHeight() / height - 1 do
    for x = 0, self.image:getWidth() / width - 1 do
      local q = love.graphics.newQuad(x * width, y * height,
                                      width, height,
                                      self.image:getWidth(),
                                      self.image:getHeight())
      self.frames[#self.frames + 1] = q
    end
  end
  self:resetOrigin()
end


function Entity:loadFont(font, size)
  self.font = G.fontCache:load(font or "data/font/04B_08__.ttf",
                               size or 8)
  local textOld = self.text
  self.text = ""
  self:setText(textOld)
end


function Entity:setText(text)
  if text == self.text then return end
  if not self.font then self:loadFont() end
  self.text = text
  if not self.text or self.text == "" then
    self.image = nil
    return
  end
  local lines = lume.split(self.text, "\n")
  local height = self.font:getHeight(self.text) * #lines
  local width = 0
  for i, l in ipairs(lines) do 
    width = math.max(width, self.font:getWidth(l))
  end
  self:makeImage(width, height)
  self:drawTo(function()
    local oldFont = love.graphics.getFont()
    love.graphics.setFont(self.font)
    for i = 1, #lines do
      love.graphics.print(lines[i], 0, height / #lines * (i - 1))
    end
  end)
end


function Entity:resetOrigin()
  self.origin.x = self.frameSize.width / 2
  self.origin.y = self.frameSize.height
end


function Entity:warp(x, y)
  self.x = x
  self.y = y
  self.last.x = x
  self.last.y = y
end


function Entity:kill()
  self.dead = true
end


function Entity:aabb()
  local x = self.x - self.size
  local y = self.y - self.size
  local sz2 = self.size * 2
  return x, y, sz2, sz2
end


function Entity:separate(e)
  if not self:overlaps(e) then return end
  local a = lume.angle(self.x, self.y, e.x, e.y)
  local acos = math.cos(a)
  local asin = math.sin(a)
  local sep = (self.size + e.size) - lume.distance(self.x, self.y, e.x, e.y)
              + 10e-8
  -- Separate
  self.x = self.x - acos * sep / 2
  self.y = self.y - asin * sep / 2
  e.x = e.x + acos * sep / 2
  e.y = e.y + asin * sep / 2
  -- TODO: Do velocity, maybe..
end


function Entity:onOverlap(e)
  if self.solid and e.solid then
    self:separate(e)
  end
end


function Entity:grounded()
    return self.z == 0
end


function Entity:overlaps(e)
  if self == e then return false end
  local min = self.size + e.size 
  return lume.distance(self.x, self.y, e.x, e.y, true) < min*min
end


function Entity:distanceTo(e)
  return lume.distance(self.x, self.y, e.x, e.y)
end


function Entity:getQuad(angle)
  if not angle then return self.frames[self.frame.front] end

  local a = (math.floor((angle + math.pi / 4) / (math.pi * 2) * 4)) % 4
  if a == 0 then
    return self.frames[self.frame.front]
  elseif a == 1 then
    if self.scale.x > 0 then self.scale.x = self.scale.x * -1 end
    return self.frames[self.frame.side]
  elseif a == 2 then
    return self.frames[self.frame.back]
  else
    if self.scale.x < 0 then self.scale.x = self.scale.x * -1 end
    return self.frames[self.frame.side]
  end
end


function Entity:randomFrame()
  self:setFrame(math.random(#self.frames))
end


function Entity:setFrame(idx)
  self.frame = self.frame or {}
  self.frame.front = idx
  self.frame.side = idx
  self.frame.back = idx
end


function Entity:play(name, reset)
  self.animation = self.animations[name]
  if reset then self.animationTimer = 0 end
end


function Entity:addAnimation(name, frames, fps)
  frames.front = frames.front or frames
  frames.back = frames.back or frames
  frames.side = frames.side or frames
  self.animations[name] = { frames = frames, period = 1 / fps }
  self:play(name)
end


function Entity:updateAnimation(dt)
  if not self.animation then return end
  self.animationTimer = self.animationTimer + dt
  local a = self.animation
  local index = math.floor(self.animationTimer / a.period) + 1
  if index > #a.frames.front then
    self.animationTimer = 0
    index = 1
  end
  self.frame.front = a.frames.front[index]
  self.frame.side = a.frames.side[index]
  self.frame.back = a.frames.back[index]
end


function Entity:updateMovement(dt)
  -- Set last position
  Vec3.clone(self, self.last)
  -- Update velocity
  for _, a in pairs(Vec3.axes) do
    self.velocity[a] = self.velocity[a] + self.accel[a] * dt
  end
  -- Cap velocity
  local s = self.velocity:magnitude()
  if s > self.maxVelocity then
    local m = self.maxVelocity / s
    self.velocity.x = self.velocity.x * m
    self.velocity.y = self.velocity.y * m
  end
  -- Update position
  for _, a in pairs(Vec3.axes) do
    self[a] = self[a] + self.velocity[a] * dt
  end
  -- Apply drag in x and y direction
  if self.drag ~= 0 and 
     math.abs(self.accel.x) + math.abs(self.accel.y) == 0 then
    for _, a in pairs({'x','y'}) do
      self.velocity[a] = self.velocity[a] - 
                         self.velocity[a] * (self.drag * dt)
    end
  end
  -- Do angularVelocity
  self.angle = self.angle + self.angularVelocity * dt
end


function Entity:updateZCollision()
  -- Handles the entity colliding with the floor
  if self.z < 0 then
    self.z = 0
    self.velocity.z = self.velocity.z * -self.bounce 
  end
end


function Entity:update(dt)
  self.tween:update(dt)
  self:updateAnimation(dt)
  self:updateMovement(dt)
  self:updateZCollision(dt)
  self.timer:update(dt)
end


function Entity:draw2d()
  -- Draws the entity straight to the screen in 2d spacing, using it's x, y
  -- position as the pixel offset from the top-left of the screen. This
  -- function is useful for things like HUD elements.
  if self.alpha == 0 then return end
  if not self.image then return end
  if self.color then
    local r, g, b = lume.rgba(self.color)
    love.graphics.setColor(r, g, b, self.alpha * 255)
  else
    love.graphics.setColor(255, 255, 255, self.alpha * 255)
  end
  love.graphics.drawq(self.image, self:getQuad(), self.x, self.y,
                      self.angle, self.scale.x, self.scale.y, 
                      self.origin.x, self.origin.y)
                      
end


function Entity:onUse(user)
  print("using me :-(")
  -- default does nothing
end


function Entity:onSpawn()
  -- default does nothing
end
