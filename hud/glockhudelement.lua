--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'hud.hudelement'

GlockHudElement = HudElement:extend()


function GlockHudElement:new(hud, glock)
  self.glock = glock
  GlockHudElement.super.new(self, hud)
  self.y = G.height - self.height - 10
end


function GlockHudElement:refresh()
  self:setText(self.glock.loadedAmmo .. "|" .. self.hud.player.items.glockAmmo)
  self.x = G.width - self.width - 10
end
