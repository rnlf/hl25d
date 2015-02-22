--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "group"

-- A state which the game can be in. A state contains an update and draw
-- method.  An example of a state could be the title menu, or the regular play
-- state.

State = Group:extend()

function State:new()
  -- [[ HEY, LISTEN! ]]
  -- Never override the new() function else bad things will happen. Override
  -- create() instead.
  State.super.new(self)
  -- Init the fx overlay, used for screen flashes and other such fun
  self.fxOverlay = Entity()
  self.fxOverlay:makeImage(G.width, G.height, 0xFFFFFFFF)
  self.fxOverlay.alpha = 0

  self.tween = flux.group()
end


function State:create()
  -- This is called the moment the state becomes active
end


function State:switchState(s)
  G.state = s
  s:create()
end


function State:onKeyDown(k)
end


function State:onKeyUp(k)
end


function State:flash(color, time, peak, onComplete)
  self.fxOverlay.color = color or 0xFFFFFF
  self.fxOverlay.alpha = peak or 1
  local t = self.tween:to(self.fxOverlay, time or .5, { alpha = 0 })
    :ease("linear")
  if onComplete then
    t:oncomplete(onComplete)
  end
end



function State:draw()
  self:draw2d()
  self.fxOverlay:draw2d()
end
