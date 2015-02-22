--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "entity"
-- The base class for all collectible item.


Item = Entity:extend()

function Item:new()
  Item.super.new(self)
  self.solid = false
  
end


function Item:onOverlap(e)
  if e:is(Player) then
    self:onCollect(e)
  end
end


function Item:onCollect(player)
  player.hud:refresh()

  if self.collect then
    local collectFn = G.state.level:getLevelVar(self.collect)
    if collectFn then
      collectFn(self)
    end
  end
end
