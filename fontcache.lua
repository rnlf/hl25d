--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
FontCache = Object:extend()

function FontCache:new()
  self.cache = {}
end

function FontCache:load(font, size)
  if not self.cache[font] then
    self.cache[font] = {}
  end

  if not self.cache[font][size] then
    self.cache[font][size] = love.graphics.newFont(font, size)
  end

  return self.cache[font][size]
end
