--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'entity'

-- The base class for all mobs.


Mob = Entity:extend()

function Mob:new()
  Mob.super.new(self)
  
end


function Mob:canSee(e)
  return not e.grabbed and G.state.level:lineOfSight(self, e)
end


function Mob:moveTowards(e, speed)
  speed = speed or .5
  local xDistance = e.x - self.x
  local yDistance = e.y - self.y
  self.velocity:set(tools.scale(xDistance,yDistance,speed))
end


function Mob:onDie(source)
  self.timer:clear()
  self.solid = false
  self.drag = 5
  self:play("dead")
  -- Do movement
  local dx, dy = tools.scale(self.x - source.x, self.y - source.y, 8)
  self.velocity.x = self.velocity.x + dx
  self.velocity.y = self.velocity.y + dy
end
