--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'mob.mob'
require 'alienblood'

Headcrab = Mob:extend()

Headcrab.walkSpeed = 0.5
Headcrab.jumpHorizontalSpeed = 4
Headcrab.jumpVerticalSpeed = 1.7
Headcrab.maxWalkDistance = 5
Headcrab.maxJumpDistance = 2
Headcrab.jumpInterval = 3
Headcrab.dampening = 0.5
Headcrab.defaultHealth = 20
Headcrab.defaultSize = .3


function Headcrab:new()
  Headcrab.super.new(self)
  self:loadImage("data/image/mob/headcrab.png", 12)
  self:addAnimation("attack", {4}, 1)
  self:addAnimation("main", {1, 2, 3}, 4)
  self:addAnimation("dead", {5}, 1)

  self.size = self.defaultSize
  self.scale:set(self.defaultSize, self.defaultSize)
  self.accel.z = -3
  self.canJump = true
  self.canAttack = true

  self.health = Health(self.defaultHealth)
  self.health.onHurt = lume.fn(self.onHurt, self)
  self.health.onDie = lume.fn(self.onDie, self)

  self.timer:loop(lume.fn(Headcrab.updateAi, self), .1)
end


function Headcrab:onDie(source)
  self.health = nil
  Headcrab.super.onDie(self,source)
end


function Headcrab:onHurt(health, source)
  G.state.world:add(AlienBlood(self.x, self.y, self.z, 0.75))
end


function Headcrab:onOverlap(e)
  if e:is(Player) then
    self.velocity:set(-self.dampening * self.velocity.x,
                      -self.dampening * self.velocity.y,
                       self.dampening * self.velocity.z)

    -- Only hurt player when jumping. Headcrab on the floor is harmless
    if self.canAttack and not self:grounded() then
      e.health:hurt(10, self)
      self.canAttack = false
      self.timer:delay(function () self.canAttack = true end,
                       self.jumpInterval)
    end
  end

  Headcrab.super.onOverlap(self, e)
end


function Headcrab:canAttackPlayer(player, playerDist)
  return self.canJump and 
         self:canSee(player) and 
         playerDist < self.maxJumpDistance
end


function Headcrab:attackPlayer(player)
  self:moveTowards(player, self.jumpHorizontalSpeed)
  self.velocity.z = self.jumpVerticalSpeed
  self.canJump = false
  self.timer:delay(function () self.canJump = true end,
                   self.jumpInterval)
  self:play("attack")
end


function Headcrab:updateAi()
  -- Only if touching the ground
  if self:grounded() then
    local player = G.state.player
    local playerDist = self:distanceTo(player)

    self:play("main")

    if self:canAttackPlayer(player, playerDist) then
      self:attackPlayer(player)

    elseif self:canSee(player) and playerDist < self.maxWalkDistance then
      self:moveTowards(player, self.walkSpeed)

    else
      self.velocity:set(0,0,0)
    end
  end
end

