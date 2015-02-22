--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

local mouse = {
  locked = false,
  unlockTimer = 0,
  velocity = { x = 0, y = 0 },
  position = { x = 0, y = 0 },
  origin = { x = G.screen.width / 2, y = G.screen.height / 2 },
  down = {},
  pressed = {},
  _pressed = {}
}

function mouse.lock()
  lume.trace("mouse lock enabled")
  mouse.locked = true 
  mouse.unlockTimer = .1
  mouse.velocity.x = 0
  mouse.velocity.y = 0
  love.mouse.setGrab(true)
  love.mouse.setVisible(false)
  love.mouse.setPosition(mouse.origin.x, mouse.origin.y)
end


function mouse.unlock()
  lume.trace("mouse lock disabled")
  mouse.locked = false
  love.mouse.setGrab(false)
  love.mouse.setVisible(true)
end


function mouse.reset()
  -- Resets the pressed-button state. This should be called if we've handled
  -- the mouse press but don't want any other part of the code to know the
  -- mouse was pressed.
  self.pressed = {}
end


function mouse.update(dt)
  local x, y = love.mouse.getPosition()
  mouse.position.x, mouse.position.y = x / G.config.scale, y / G.config.scale
  -- Handle locked mouse
  mouse.unlockTimer = mouse.unlockTimer - dt
  if mouse.locked then
    if mouse.unlockTimer < 0 then
      mouse.velocity.x = x - mouse.origin.x
      mouse.velocity.y = y - mouse.origin.y
    end
    love.mouse.setPosition(mouse.origin.x, mouse.origin.y)
  end
  -- Reset mouse-pressed state
  mouse.pressed = mouse._pressed
  mouse._pressed = {}
end


function mouse.onButtonDown(button)
  mouse._pressed[button] = true
  mouse.down[button] = true
end


function mouse.onButtonUp(button)
  mouse.down[button] = nil
end


return mouse
