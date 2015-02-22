--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'usable.usabletile'

Button = UsableTile:extend()

function Button:new(level, x,y)
  Button.super.new(self, level, x, y)
  -- resetTime = 0 means it will reset by being used by the player again
  -- resetTime = -1 means it cannot be reset
  self.resetTime = 2
  self.onActivate = ''
  self.onDeactivate = ''
  self.active = false
  self.enabled = true
  self.alterWallTile = true

  -- These are not meant to be set in the map file
  self.noWallCollisions = true
end


function Button:onUse(user, hold)
  -- Do not allow toggling disabled buttons
  if not self.enabled then return end

  -- Avoid rapid toggling
  if hold then return end

  if self.resetTime == 0 then
    -- toggle button
    if self.active then
      self:deactivate()
    else
      self:activate()
    end
  else
    -- button resets automatically, quit if it is active
    if self.active then return end

    -- activate
    self:activate()
    if self.resetTime > 0 then
      self.level.timer:delay(lume.fn(self.deactivate, self), self.resetTime)
    end
  end
end


function Button:activate()
  local activateFn = self.level:getLevelVar(self.onActivate)
  if activateFn then
    activateFn(self)
  end
  self.active = true
  if self.alterWallTile then
    self:alterWall(2)
  end
end


function Button:deactivate()
  local deactivateFn = self.level:getLevelVar(self.onDeactivate)
  if deactivateFn then
    deactivateFn(self)
  end
  self.active = false
  if self.alterWallTile then
    self:alterWall(1)
  end
end
