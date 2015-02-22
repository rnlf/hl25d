--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
Weapon = Object:extend()

function Weapon:new(owner)
    Weapon.super.new(self)

    self.owner = owner
end


function Weapon:firePrimary()

end


function Weapon:fireSecondary()

end


function Weapon:reload()

end


function Weapon:equip(onFinish)
  G.state.weaponOverlay.offset:set(0,120)
  self.owner.tween:to(G.state.weaponOverlay.offset, .5, { y = 0 })
    :oncomplete(onFinish)
end


function Weapon:unequip(onFinish)
  G.state.weaponOverlay.offset:set(0,0)
  self.owner.tween:to(G.state.weaponOverlay.offset, .5, { y = 120 })
    :oncomplete(onFinish)
end


function Weapon:knockback(amount)
  amount = amount or 2
  local v = self.owner.velocity
  v.x = v.x - math.cos(self.owner.facing) * amount
  v.y = v.y - math.sin(self.owner.facing) * amount
end


function Weapon:expelCasing(image)
  -- HEY, LISTEN! Don't move any of this code out of this function.
  local c = Entity()
  if image then
    c:loadImage(image)
  else
    c:makeImage(2, 4, 0xFFFF00FF)
  end
  c.scale:set(.05, .05)
  c.velocity.z = lume.random(1.6, 2)
  c.accel.z = -10
  c.bounce = .8
  c.drag = 1
  c.angle = lume.random(360)
  c.angularVelocity = lume.random(-200, 200)
  c.size = .05
  c.solid = false
  self.owner.tween:to(c, 1, { angularVelocity = 0 })
  self.owner.tween:to(c, .5, { alpha = 0 })
    :delay(lume.random(1, 3))
    :oncomplete(lume.fn(c.kill, c))
  G.state.world:add(c)
  -- Place a bit in front of parent
  local parent = self.owner
  c.x = parent.x + math.cos(parent.facing) * .5
  c.y = parent.y + math.sin(parent.facing) * .5
  c.z = .35
  -- Set velocity to fly away to the right 
  c.velocity.x = math.cos(parent.facing + 90) * 1 + parent.velocity.x * .6
  c.velocity.y = math.sin(parent.facing + 90) * 1 + parent.velocity.y * .6
  -- Offset a little to align with the gun
  c.x = c.x + math.cos(parent.facing + 90) * .11
  c.y = c.y + math.sin(parent.facing + 90) * .11
end




function Weapon:usable()
  return true
end


function Weapon:update(dt)

end
