--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
ImageCache = Object:extend()

function ImageCache:new()
  self.cache = {}
end

function ImageCache:load(filename)
  if not self.cache[filename] then
    self.cache[filename] = love.graphics.newImage(filename)
    self.cache[filename]:setFilter("nearest", "nearest")
  end
  return self.cache[filename]
end
