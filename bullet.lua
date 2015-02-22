--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'bulletimpact'

Bullet = Object:extend()


function Bullet.shoot(sx,sy,angle,damage,source,maxDist,deviation)

  if source.grabbed then
    if source.grabbed.health then
      source.grabbed.health:hurt(damage)
    end
    return
  end

  if deviation then
    angle = angle + love.math.randomNormal(deviation)
  end

  local impact = G.state.level:castRay(sx,sy,angle,maxDist,
    function(e)
      return e ~= source and e.wasVisible and e.health
    end)

  if impact.type == 'wall' then
    local offsetZ = 0
    if deviation then
      offsetZ = offsetZ + love.math.randomNormal(deviation)
    end
    local wallOffsetX, wallOffsetY = tools.scale(
      impact.wall.ix - sx,
      impact.wall.iy - sy, 0.01)

    G.state.world:add(
      BulletImpact(
        impact.wall.ix-wallOffsetX,
        impact.wall.iy-wallOffsetY,
        0.5+offsetZ))

  elseif impact.type == 'entity' then
    if impact.entity.health then
      impact.entity.health:hurt(damage, source)
    end
  end

end
