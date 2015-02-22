--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "entity"

-- A basic menu with a number of items. When an item is selected a callback
-- function is called with the arguments: <Menu, Item, Index>

Menu = Entity:extend()

function Menu:new(items, onSubmit)
  Menu.super.new(self)
  self.index = 1
  self.items = items
  self.onSubmit = onSubmit
  self.mouseLast = { x = 0, y = 0 }
  self:recalc()
end


function Menu:recalc()
  local t = {}
  for i, v in ipairs(self.items) do
    t[#t + 1] = (i == self.index and ">" or " ") .. v
  end
  self:setText(lume.trim(table.concat(t, "\n"), "\n"))
end


function Menu:isMouseOver()
  local x, y = G.mouse.position.x, G.mouse.position.y
  return x >= self.x and y >= self.y and
         x < self.x + self.frameSize.width and
         y < self.y + self.frameSize.height
end


function Menu:isMouseActive()
  local x, y = G.mouse.position.x, G.mouse.position.y
  local res = x ~= self.mouseLast.x or y ~= self.mouseLast.y
  self.mouseLast.x, self.mouseLast.y = x, y
  return res
end


function Menu:submit(index)
  self.index = index or self.index
  if self.onSubmit then
    self.onSubmit(self, self.items[self.index], self.index)
  end
end 


function Menu:update(dt)
  Menu.super.update(self, dt)
  -- Handle mouse move
  if self:isMouseOver() then
    -- Handle mouse move
    if self:isMouseActive() then
      local idx = math.floor((G.mouse.position.y - self.y) /
                             self.height *
                             #self.items + 1)
      if idx ~= self.index then 
        self.index = idx
        self:recalc()
      end
    end
    -- Handle mouse click
    if G.mouse.pressed["l"] then
      self:submit()
    end
  end
end


function Menu:onKeyDown(k)
  if k == "up" and self.index > 1 then
    self.index = self.index - 1
    self:recalc()
  end
  if k == "down" and self.index < #self.items then
    self.index = self.index + 1
    self:recalc()
  end
  if k == "return" then
    self:submit()
  end
end
