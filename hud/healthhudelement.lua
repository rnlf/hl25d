--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'hud.hudelement'

HealthHudElement = HudElement:extend()


function HealthHudElement:new(hud)
  self.glock = glock
  HealthHudElement.super.new(self, hud)
  self.y = G.height - self.height - 10
  self.x = 10
end


function HealthHudElement:refresh()
  local text = "+" .. self.hud.player.health.health
  if self.hud.player.health:is(Armor) then
    text = text .. " #" .. self.hud.player.health.armor
  end

  self:setText(text)
end
