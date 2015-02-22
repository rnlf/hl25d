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

Barnacle = Mob:extend()

Barnacle.defaultSize = .3
Barnacle.defaultHealth = 50

function Barnacle:new()
  Barnacle.super.new(self)

  self:loadImage("data/image/mob/barnacle.png", 13)
  self:addAnimation("dead", {4}, 1)
  self:addAnimation("lurk", {1,2,3,2}, 1)

  self.size = self.defaultSize
  self.hasShadow = false
  self.solid = false

  self.health = Health(self.defaultHealth)
  self.health.onHurt = lume.fn(self.onHurt, self)
  self.health.onDie = lume.fn(self.onDie, self)
  self.canAttack = true
  self.canGrab = true
end


function Barnacle:onHurt(health, source)
  G.state.world:add(AlienBlood(self.x, self.y, 0.9, 0.75))
end


function Barnacle:onDie(source)
  self.health = nil
  self:play("dead")
  self.canGrab = false
  if self.grabbedEntity then
    self.grabbedEntity.grabbed = false
    self.grabbedEntity.accel.z = self.oldAccelZ
    self.grabbedEntity = nil
  end
end


function Barnacle:onOverlap(e)
  local canGrab = self.health and self.canGrab and
                  not e.grabbed and not self.grabbedEntity
  if canGrab then
    if e.health and e.health.health == 0 then return end
    self.grabbedEntity = e
    e.grabbed = self
    self.oldAccelZ = e.accel.z
    e.accel.z = 0.1
    self.canGrab = false
  end
end


function Barnacle:update(dt)

  if self.grabbedEntity then
    local g = self.grabbedEntity
    local dx = g.x - self.x
    local dy = g.y - self.y

    local dragx, dragy = tools.normalize(g.velocity.x, g.velocity.y)
    local magVsq =   g.velocity.x * g.velocity.x
                   + g.velocity.y * g.velocity.y

    g.velocity.x = g.velocity.x - 0.05*dragx * magVsq
    g.velocity.y = g.velocity.y - 0.05*dragy * magVsq
  
    g.accel:set(-100*dx,
                 -100*dy)

    if g.z > .9 - g.height then
      g.accel.z = 0
      g.velocity.z = 0
      if g.health and g.health.health > 0 then
        if self.canAttack then
          self.canAttack = false
          g.health:hurt(10, self)
          self.timer:delay(function()
            self.canAttack = true
          end, 1)
        end
      else
        g.grabbed = nil
        g.velocity:set(1,0)
        g.accel:set(0,0,self.oldAccelZ)
        self.grabbedEntity = nil
        self.timer:delay(function()
          self.canGrab = true
        end, 3)
      end
    end
  end

  Barnacle.super.update(self,dt)
end

