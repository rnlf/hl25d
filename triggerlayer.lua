--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
require 'trigger'
local util  = require 'util'

TriggerLayer = Object:extend()

function TriggerLayer:new(level, layer)
  self.level = level
  self.triggers = {}
  self.activeTriggers = {}
end


function TriggerLayer:readTriggers(layer)
  local tw, th = self.level.tilewidth, self.level.tileheight
  local lw = self.level.width

  for i = 1, #layer.objects do
    local trigDef = layer.objects[i]
    local trigger
    local x,y = trigDef.x / tw, trigDef.y / th
    if trigDef.shape == 'polygon' and trigDef.polygon then
      local pts = {}
      for j = 1, #trigDef.polygon do
        pts[j] = {trigDef.polygon[j].x / tw + x,
                  trigDef.polygon[j].y / th + y}
      end
      trigger = Trigger(self.level, pts)
    elseif trigDef.shape == 'rectangle' then
      if trigDef.width == 0 or trigDef.height == 0 then
        lume.trace("Warning, trigger at " ..trigDef.x .. ", " .. trigDef.y ..
                      " has rectangular shape and zero width or height")
      end
  
      local w = trigDef.width / tw
      local h = trigDef.height / th

      trigger = Trigger(self.level, {
          {x, y},
          {x, y+h},
          {x+w, y+h},
          {x+w, y}
        })
    end
    util.applyProperties(trigger, trigDef.properties)

    for y = math.floor(trigger.ymin), math.floor(trigger.ymax) do
      for x = math.floor(trigger.xmin), math.floor(trigger.xmax) do
        local idx = lw * y + x
        if self.triggers[idx] == nil then
          self.triggers[idx] = {}
        end

        table.insert(self.triggers[idx], trigger)
      end
    end
  end
end


function TriggerLayer:test(x, y)
  local tx, ty = math.floor(x), math.floor(y)

  for trigger,_ in pairs(self.activeTriggers) do
    local stillActive = trigger:test(x,y)
    if not stillActive then
      self.activeTriggers[trigger] = nil
      trigger:deactivate()
    end
  end

  local triggers = self.triggers[tx+self.level.width*ty]
  if triggers then
    for i = 1, #triggers do
      if not self.activeTriggers[triggers[i]] then
        local triggered = triggers[i]:test(x,y)
        if triggered then
          self.activeTriggers[triggers[i]] = triggers[i]
          triggers[i]:activate()
        end
      end
    end
  end
end
