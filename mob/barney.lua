--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
Barney = Mob:extend()
Barney.skinCount = 4


function Barney:new()
  Barney.super.new(self)

  self:prepareAnims()

  self.skin = 1
end


function Barney:prepareAnims()
  self:loadImage("data/image/mob/barney.png", 24, 24)
  self.scale:set(0.75, 0.75)
  self.skins = {}
  for i = 1, Barney.skinCount do
    local n = tostring(i)
    local o = (i-1) * 12
    self.skins[i] = {
      walk = "walk" .. n,
      idle = "idle" .. n
    }
    local s = self.skins[i]
    self:addAnimation(s.walk, { front = { 1 },
                                back  = { 1 },
                                side  = { 1 }}, 4)
    self:addAnimation(s.idle, { front = { 1 },
                                back  = { 1 },
                                side  = { 1 }}, 1)
  end
end


function Barney:onSpawn()
  Barney.super.onSpawn(self)

  self:play(self.skins[self.skin].idle)
end
