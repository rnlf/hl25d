--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--
Timer = Object:extend()

function Timer:new()
  self.events = {}
  self.funcs = { abort = lume.fn(self.abort, self),
                 again = lume.fn(self.again, self) }
end


function Timer:update(dt)
  if #self.events == 0 then return end
  local _abort, _again = abort, again
  abort, again = self.funcs.abort, self.funcs.again
  for i = #self.events, 1, -1 do
    local t = self.events[i]
    t.timer = t.timer - dt
    while t.timer <= 0 do
      self.lastEvent = t
      t.fn()
      self.lastEvent = nil
      if t.loop then
        t.timer = t.timer + t.delay
      else
        table.remove(self.events, i)
        break
      end
    end
  end
  abort, again = _abort, _again
end


function Timer:delay(fn, delay, name)
  local t = TimerEvent(fn, delay, self, name)
  table.insert(self.events, t)
  return t
end


function Timer:loop(fn, delay, name)
  local t = TimerEvent(fn, delay, self, name, true)
  table.insert(self.events, t)
  return t
end


function Timer:clear(name)
  if not name then
    self.events = {}
  else
    self.events = lume.filter(self.events, 
                              function(x) return x.name ~= name end)
  end
end


function Timer:again(delay)
  if not self.lastEvent then
    error("again() must be called from inside a timer callback function")
  end
  if self.lastEvent.loop then
    error("again() cannot be called on a looping event")
  end
  self:delay(self.lastEvent.fn, delay or self.lastEvent.delay)
end


function Timer:abort()
  if not self.lastEvent then
    error("abort() must be called from inside a timer callback function")
  end
  if not self.lastEvent.loop then
    error("abort() cannot be called on a non-looping event")
  end
  self.lastEvent.loop = false
end




TimerEvent = Object:extend()


function TimerEvent:new(fn, delay, parent, name, loop)
  self.fn = fn
  self.name = name
  self.delay = delay or 0
  self.timer = self.delay
  self.loop = loop and true or false
  self.parent = parent
end


function TimerEvent:after(fn, delay)
  if self.loop then
    error("Cannot chain with a looped timer event")
  end
  return self.parent:delay(fn, (delay or self.delay) + self.delay)
end
