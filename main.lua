--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "love8to9"
lume = require "lume.lume"
Object = require "classic.classic"
tools = require 'lust.tools'

flux = require "flux.flux"
require "entityfactory"
require "playstate"
require "menustate"
require "imagecache"
require "fontcache"


function love.load()
  -- Init everything
  lume.trace("initing everything")
  G.imageCache = ImageCache()
  G.fontCache = FontCache()
  G.mouse = require "mouse"
  G.canvas = love.graphics.newCanvas(G.width, G.height)
  G.canvas:setFilter('nearest', 'nearest')
  -- Init state
  lume.trace("initing state")
  G.state = MenuState()
  G.state:create()

  -- Set up lovebird if debug mode is enabled
  if G.config.debug then
    G.lovebird = require('lovebird.lovebird')
    local oldUpdate = love.update
    love.update = function(dt)
      G.lovebird.update()
      oldUpdate(dt);
    end
  end
end


function love.keypressed(key)
  G.state:onKeyDown(key)
  -- Debug hotkeys
  if G.config.debug then
    if key == "f2" then G.mouse.lock() end
    if key == "f3" then G.mouse.unlock() end
    --if key == "escape" then love.event.quit() end
  end
end


function love.keyreleased(key)
  G.state.onKeyUp(key)
end


function love.mousepressed(x, y, button)
  G.mouse.onButtonDown(button)
end


function love.mousereleased(x, y, button)
  G.mouse.onButtonUp(button)
end


function love.update(dt)
  -- Init screenshake stuff, will possibly be overwritten by state update
  G.screenShake = 0
  G.mouse.update(dt)
  G.state:update(dt)
end


function love.draw()
  love.graphics.setCanvas(G.canvas)
  G.state:draw()
  love.graphics.setCanvas()
  love.graphics.reset()
  love.graphics.push()
  -- Do screenshake translate
  local s = G.config.scale
  love.graphics.translate(
    lume.round(lume.random(-1, 1) * G.screenShake * s, s),
    lume.round(lume.random(-1, 1) * G.screenShake * s, s))
  love.graphics.draw(G.canvas, 0, 0, 0, G.config.scale, G.config.scale)
  love.graphics.pop()
  -- Draw FPS stuff
  if G.config.debug then
    love.graphics.setColor(255, 255, 0, 255)
    love.graphics.print(love.timer.getFPS() .. " FPS", 5, 5)
  end
end
