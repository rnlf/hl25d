--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
Crate = Entity:extend()

Crate.defaultHealth = 80
Crate.shardCount = 40


function Crate:new()
  Crate.super.new(self)

  self:loadImage("data/image/crate.png")
  self.size = .5
  self.scale:set(.4, .4)
  self.drag = 10

  self.health = Health(self.defaultHealth)
  self.health.onHurt = lume.fn(self.onHurt, self)
  self.health.onDie  = lume.fn(self.onDie, self)
end


function Crate:onHurt(health, source)
  local dx, dy = self.x - source.x, self.y - source.y
  self.velocity:set(tools.scale(dx,dy, 0.5))
end


function Crate:onDie(source)
  for i = 1, self.shardCount do
    local e = Entity()
    e:loadImage("data/image/crate_shards.png", 8)
    e:randomFrame()
    e:set(self.x + lume.random(-0.15, 0.15),
          self.y + lume.random(-0.15, 0.15),
          lume.random(0, 0.3))
  
    if G.state.level:canSpawn(e) then
      e.size = .15
      e.solid = false
      e.accel.z = lume.random(-2.5, -3)
      e.velocity.x = lume.random(-.3, .3)
      e.velocity.y = lume.random(-.3, .3)
      e.velocity.z = lume.random(0, 1)
      e.angularVelocity = lume.random(-200, 200)
      e.angle = lume.random(-5, 5)
      e.bounce = .7
      e.scale:set(.1, .1)
      G.state.world:add(e)
      self.tween:to(e, 1, { alpha = 0 })
        :delay(lume.random(1, 2))
        :oncomplete(lume.fn(e.kill, e))
    end
  end

  self:kill()
end

