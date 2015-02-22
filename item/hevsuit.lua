--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'item.item'

HEVSuit = Item:extend()


function HEVSuit:new()
  HEVSuit.super.new(self)

  self:loadImage("data/image/items/hevsuit.png")
  self:addAnimation("idle", {1}, 1)
  self.scale:set(0.6, 0.6)
  self.size = 0.2
end


function HEVSuit:onCollect(player)
  if player.hud.hidden then
    G.state:flash(0xFFA000, 2, 0.7)
    G.state:multiSubtitle({
        {"Welcome", 2},
        {"To the H.E.V. mark IV protective system", 3},
        {"For use in hazardous environment conditions", 4},
        {"High impact reactive armor", 2},
        {"Activated", 2},
        {"Atmospheric contaminant sensors", 2},
        {"Activated", 2},
        {"Vital sign monitoring", 2},
        {"Activated", 2},
        {"Automatic medical systems", 2},
        {"Engaged", 2},
        {"Defensive weapon selection system", 2},
        {"Activated", 2},
        {"Ammunition level monitoring", 2},
        {"Activated", 2},
        {"Communications interface", 2},
        {"Online", 2},
        {"Have a _V_E_R_Y_ safe day", 3},
      }, 160,220,8, 1)
    
    player.hud.hidden = nil
    HEVSuit.super.onCollect(self, player)
    self:kill()
  end
end
