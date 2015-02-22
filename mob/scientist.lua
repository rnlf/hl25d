--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
Scientist = Mob:extend()
Scientist.skinCount = 4


function Scientist:new()
  Scientist.super.new(self)

  self:prepareAnims()

  self.skin = 1
end


function Scientist:prepareAnims()
  self:loadImage("data/image/mob/scientist.png", 24, 24)
  self.scale:set(0.75, 0.75)
  self.skins = {}
  for i = 1, Scientist.skinCount do
    local n = tostring(i)
    local o = (i-1) * 12
    self.skins[i] = {
      walk = "walk" .. n,
      idle = "idle" .. n
    }
    local s = self.skins[i]
    self:addAnimation(s.walk, { front = { 1 + o, 2 + o, 3 + o, 4 + o },
                                back  = { 5 + o, 6 + o, 7 + o, 8 + o },
                                side  = { 9 + o, 10+ o, 11+ o, 12+ o }}, 4)
    self:addAnimation(s.idle, { front = { 1 + o },
                                back  = { 5 + o },
                                side  = { 9 + o }}, 1)
  end
end


function Scientist:onSpawn()
  Scientist.super.onSpawn(self)

  self:play(self.skins[self.skin].idle)
end
