--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "group"
require "menu"

-- The menu which is displayed in-game when the escape key is pressed

GameMenu = Group:extend()


function GameMenu:new()
  GameMenu.super.new(self)
  -- Init
  self.collision = false
  G.mouse.unlock()

  -- Do background
  self.bg = Entity()
  self.bg:makeImage(G.width, G.height, 0xFF101010)
  self.bg.alpha = 0
  self:add(self.bg)

  -- Do menu
  local onSubmit = function(menu, item)
    if item == "Continue" then
      self:kill()
    end
    if item == "Exit" then
      G.state:switchState(MenuState())
    end
  end
  self.menu = Menu( { "Continue", "Restart", "Exit" }, onSubmit)
  self.menu.x = 20
  self.menu.y = (G.height - self.menu.height) - 20
  self.menu.alpha = 0
  self:add(self.menu)

  -- Tween everything in
  self.tween:to(self.bg, .2, { alpha = .85 })
    :ease("linear")
    :oncomplete(
      function()
        self.tween:to(self.menu, .2, { alpha = 1 }):ease("linear")
      end)
end


function GameMenu:kill()
  if self.killing then return end
  self.killing = true
  self.tween:to(self.menu, .2, { alpha = 0 })
    :ease("linear")
    :oncomplete(
      function()
        self.tween:to(self.bg, .2, { alpha = 0 })
          :ease("linear")
          :oncomplete(
            function()
              if self.onKill then self.onKill() end
              GameMenu.super.kill(self)
              G.mouse.lock()
            end)
      end)
end


function GameMenu:onKeyDown(k)
  if k == "escape" then
    self:kill()
  else
    self.menu:onKeyDown(k)
  end
end
