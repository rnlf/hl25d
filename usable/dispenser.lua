--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'usable.usabletile'

Dispenser = UsableTile:extend()

function Dispenser:new(level, x, y, amount, size, delay)
  Dispenser.super.new(self, level, x, y)
  self.amount = amount
  self.dispensing = false
  self.delay = delay
end

function Dispenser:onUse(user, hold)
  if not self:canUse(user) then
    return
  end

  if self.amount == 0 then
    return
  end

  if not self.dispensing then
    self.dispensing = true
    self.level.timer:delay(
      function()
        self.dispensing = false
      end, self.delay)
    self.amount = self.amount - 1
    self:affect(user)
    if self.amount == 0 then
      print("recharger empty")

      self:alterWall(2)
    end
  end
end
