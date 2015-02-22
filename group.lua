--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require "entity"

-- Stores a number of entities. Handles things like detecting overlaps
-- (collision) and removing dead entities 


Group = Entity:extend()

function Group:new()
  Group.super.new(self)
  self.members = {}
  self.sortedMembers = {}
  self.collision = true
  self.solid = false
end


function Group:add(e)
  assert(e, "entity is nil")
  table.insert(self.members, e)
  table.insert(self.sortedMembers, e)
end


function Group:remove(e)
  local index = lume.find(self.members, e)
  if index then
    table.remove(self.members, index)
    table.remove(self.sortedMembers, lume.find(self.sortedMembers, e))
  end
end


function Group:updateCollision(dt)
  local t = self.sortedMembers
  table.sort(t, lume.lambda "a,b -> a.x - a.size < b.x - b.size")
  for i = 1, #t do
    for j = i + 1, #t do
      local a, b = t[i], t[j]
      if a.x + a.size < b.x - b.size then break end
      if a:overlaps(b) then
        a:onOverlap(b)
        b:onOverlap(a)
      end
    end
  end
end


function Group:update(dt)
  -- Reverse-iterate array so removing an entity mid-way doesn't skip a frame
  -- for that entity
  for i = #self.members, 1, -1 do
    local e = self.members[i]
    e:update(dt)
    if e.dead then
      self:remove(e)
    end
  end
  -- Do collision
  if self.collision then
    self:updateCollision(dt)
  end
  -- Super
  Group.super.update(self, dt)
end


function Group:draw2d()
  if not self.hidden then
    lume.each(self.members, "draw2d")
  end
end
