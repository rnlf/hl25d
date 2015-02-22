--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "state"
require "menu"
require "playstate"

MenuState = State:extend()

function MenuState:new()
  MenuState.super.new(self)
  lume.trace("initing menustate")
  self.collision = false
  G.mouse.unlock()

  -- Init background
  self.bg = Entity()
  self.bg:makeImage(G.width, G.height, 0xFF101010)
  self:add(self.bg)

  -- Init menu
  self.menu = Menu({"Game Start", "Settings", "About", "Exit"}, 
    function(m, item)
      if item == "Game Start" then
        self:switchState(PlayState())
      end
      if item == "Exit" then
        love.event.quit()
      end
    end)
  self.menu.x = 20
  self.menu.y = (G.height - self.menu.height) - 20
  self:add(self.menu)

end


function MenuState:onKeyDown(k)
  self.menu:onKeyDown(k)
end


function MenuState:draw()
  MenuState.super.draw(self)
end
