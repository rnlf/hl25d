--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'health'

Armor = Health:extend()

function Armor:new(maxHealth, health, maxArmor, armor)
  Armor.super.new(self, maxHealth, health)
  self.maxArmor = maxArmor or 100
  self.armor = armor or 0

  self.onRecharge = function() end
end


function Armor:hurt(amount, source)
  local absorbed = math.min(amount, self.armor)
  self.armor = self.armor - absorbed
  Armor.super.hurt(self, amount - absorbed, source)
end


function Armor:heal(amount, source)
  if source.hev then
    self.armor = math.min(amount+self.armor, self.maxArmor)
    self.onRecharge(self.armor, source)
  else
    Armor.super.heal(self, amount, source)
  end
end
