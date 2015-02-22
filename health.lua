--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
Health = Object:extend()

function Health:new(maxHealth, health)
  self.maxHealth = maxHealth or 100
  self.health = health or maxHealth

  self.onHurt = function() end
  self.onHeal = function() end
  self.onDie =  function() end
end

function Health:hurt(amount, source)
  self.health = math.max(0, self.health - amount)
  if self.health == 0 then
    self.onDie(source)
  else
    self.onHurt(self.health, source)
  end
end

function Health:heal(amount, source)
  self.health = math.min(self.maxHealth, self.health + amount)
  self.onHeal(self.health, source)
end

