--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local Stripes = Object:extend()

function Stripes:new(srcX1, srcY1, srcWidth, srcHeight, refWidth, refHeight)
  self.stripes = {}
  self.width = srcWidth
  self.height = srcHeight

  for column = srcX1, srcX1 + srcWidth - 1 do
    self.stripes[#self.stripes+1] = love.graphics.newQuad(
      column, srcY1, 1, srcHeight, refWidth, refHeight
    )
  end
end

-- Zero-based column indices
function Stripes:getStripe(column)
  return self.stripes[column+1]
end

return Stripes
