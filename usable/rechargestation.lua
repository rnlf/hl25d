--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'usable.dispenser'

RechargeStation = Dispenser:extend()

RechargeStation.defaultSize = .3
RechargeStation.defaultAmount = 30

-- Time before next battery level is restored
RechargeStation.defaultDelay = .2


function RechargeStation:new(level, x, y)
  RechargeStation.super.new(self, level, x, y, self.defaultAmount,
                 self.defaultSize, self.defaultDelay)
  self.hev = true
end


function RechargeStation:canUse(user)
  return user.health and user.health.armor and 
         user.health.armor < user.health.maxArmor
end


function RechargeStation:affect(user)
  user.health:heal(1, self)
end


