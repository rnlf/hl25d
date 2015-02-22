--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

-- Provides backwards-compatibility for love 0.9.0 so it can use the
-- renamed/replaced love 0.8.0 functions. Any additional backward-compatibility
-- fixes should be placed here.
--
-- This SHOULD NOT be required by conf.lua as its means of detecting the love
-- version will not work there. It should instead be the first thing required
-- in main.lua

love.version = love.version or (love.window and "0.9.0" or "0.8.0")

if love.version == "0.9.0" then
  
  love.graphics.drawq = love.graphics.draw
  love.mouse.setGrab = love.mouse.setGrabbed

  -- SpriteBatch
  local img = love.graphics.newImage(love.image.newImageData(8, 8))
  local mt = getmetatable(love.graphics.newSpriteBatch(img))
  mt.__index.addq = mt.__index.add

elseif love.version == "0.8.0" then
  -- love 0.8 does not have love.math yet
  love.math = {}
  
  -- keep them out of randomNormal, need them to be part of the closure
  local hasSpare = false
  local rand1, rand2
  love.math.randomNormal = function(stddev, mean)
    stddev = stddev or 1
    mean = mean or 0

    -- samples a normal distribution using Box-Muller transform.
    -- Code hijacked from Wikipedia and ported to lua, also added mean
    
    if hasSpare then
      hasSpare = false
      return math.sqrt(stddev*stddev * rand1) * math.sin(rand2) + mean
    end

    hasSpare = true

    rand1 = math.random()
    if rand1 < 1e-100 then rand1 = 1e-100 end
    rand1 = -2 * math.log(rand1)
    rand2 = math.random() * math.pi * 2

    return math.sqrt(stddev*stddev * rand1) * math.cos(rand2) + mean
    
  end

end

