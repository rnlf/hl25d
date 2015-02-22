--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local Stripes = require('raycaster.stripes')

local StripedImage = Stripes:extend()

function StripedImage:new(image, srcX1, srcY1, srcWidth, srcHeight)
  self.image = image

  local sw, sh = image:getWidth(), image:getHeight()

  srcX1 = srcX1 or 0
  srcY1 = srcY1 or 0
  srcWidth = srcWidth or sw
  srcHeight = srcHeight or sh

  Stripes.new(self, srcX1, srcY1, srcWidth, srcHeight, sw, sh)
end

return StripedImage
