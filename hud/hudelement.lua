--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
HudElement = Entity:extend()

function HudElement:new(hud)
  HudElement.super.new(self)
  self.hud = hud
  self:refresh()

  self.color = Hud.elementColor
  self.alpha = Hud.elementAlpha
end


function HudElement:show()
  self.hud:addElement(self)
end


function HudElement:hide()
  self.hud:removeElement(self)
end


function HudElement:refresh()

end
