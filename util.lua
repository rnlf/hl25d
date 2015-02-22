--
-- hl2.5d
--
-- Copyright (c) 2014, rnlf, rxi, bitslap
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

local function applyProperties(object, props)
  for k,v in pairs(props) do
    local v2 = v:match("^'(.*)'$") or tonumber(v)

    assert(v2, "property must either have numeric value or be a"
               .. " string enclosed in single quotes")

    tools.scoped_set(object, k, v2)
  end 
end


return {
  applyProperties = applyProperties
}
