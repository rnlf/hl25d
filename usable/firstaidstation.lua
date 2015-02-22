--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'usable.dispenser'

FirstAidStation = Dispenser:extend()

FirstAidStation.defaultSize = .3
FirstAidStation.defaultAmount = 30

-- Time before next battery level is restored
FirstAidStation.defaultDelay = .2


function FirstAidStation:new(level, x, y)
  FirstAidStation.super.new(self, level, x, y, self.defaultAmount,
                             self.defaultSize, self.defaultDelay)
end


function FirstAidStation:canUse(user)
  return user.health and 
         user.health.health < user.health.maxHealth
end


function FirstAidStation:affect(user)
  user.health:heal(1, self)
end


