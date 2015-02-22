--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
local lume = require "lume.lume"

function love.conf(t)

  G = {}
  G.config = lume.deserialize(love.filesystem.read("config.cfg"))
  G.width, G.height = 320, 240
  G.screen = { width = G.width * G.config.scale,
               height = G.height * G.config.scale }

  if not t.window then
    t.window = t.screen
  end
  t.window.title = "Raycast Test"
  t.title = "Raycast Test"
  
  t.window.width = G.screen.width
  t.window.height = G.screen.height
  t.window.fullscreen = G.config.fullscreen
  t.vsync = true
end
