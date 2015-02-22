local lockerdooropen
local door, doorbasex
local timer

local moveFreeWall = function(wallname, xoffset, yoffset, time)
  local door = G.state.level.freewalls:getFreeWall(wallname)
  local data = {
    door = door,
    x1 = door.x1,
    y1 = door.y1,
    x2 = door.x2,
    y2 = door.y2,
    alpha = 0
  }

  local moveDoor = function()
    data.door.x1 = data.x1 + data.alpha * xoffset
    data.door.y1 = data.y1 + data.alpha * yoffset
    data.door.x2 = data.x2 + data.alpha * xoffset
    data.door.y2 = data.y2 + data.alpha * yoffset
  end

  return G.state.tween:to(data, time, {alpha = 1})
    :ease('linear')
    :onupdate(moveDoor)
end


local rotateFreeWall = function(wallname, pivotX, pivotY, angle, time)
  local door = G.state.level.freewalls:getFreeWall(wallname)
  local data = {
    door = door,
    x1 = door.x1 - pivotX,
    y1 = door.y1 - pivotY,
    x2 = door.x2 - pivotX,
    y2 = door.y2 - pivotY,
    alpha = 0
  }

  local moveDoor = function()
    local x1, y1 = tools.rotate(data.x1, data.y1, data.alpha * angle)
    local x2, y2 = tools.rotate(data.x2, data.y2, data.alpha * angle)

    door.x1 = x1 + pivotX
    door.x2 = x2 + pivotX
    door.y1 = y1 + pivotY
    door.y2 = y2 + pivotY
  end

  return G.state.tween:to(data, time, {alpha = 1})
    :ease('linear')
    :onupdate(moveDoor)
end


local closeAndOpenElevatorDoors = function(elevator)
  local elevStr = tostring(elevator)
  timer:delay(function()
    moveFreeWall('elevator' .. elevStr .. 'Level1Door1', 0, 7/16, 1)
    moveFreeWall('elevator' .. elevStr .. 'Level2Door1', 0, 7/16, 1)
    moveFreeWall('elevator' .. elevStr .. 'Level1Door2', 0, -7/16, 1)
    moveFreeWall('elevator' .. elevStr .. 'Level2Door2', 0, -7/16, 1)
    timer:delay(function()
      moveFreeWall('elevator' .. elevStr .. 'Level1Door1', 0, -7/16, 1)
      moveFreeWall('elevator' .. elevStr .. 'Level2Door1', 0, -7/16, 1)
      moveFreeWall('elevator' .. elevStr .. 'Level1Door2', 0, 7/16, 1)
      moveFreeWall('elevator' .. elevStr .. 'Level2Door2', 0, 7/16, 1)
    end, 5)
  end, 2)
end


return {
  map = 'map001',
  data = {
    init = function()
      G.state.player.hud.hidden = true

      timer = G.state.level.timer
      timer:delay(function() 
        moveFreeWall('entranceDoor1', -.9, 0, 4)
        moveFreeWall('entranceDoor2',  .9, 0, 4)
      end, 4)
      timer:delay(function()
        G.state:subtitle("Anomalous Materials", G.width / 2, G.height - 40, 16)
      end, 2)
    end,

    elevator1Down = function()
      closeAndOpenElevatorDoors(1)
      timer:delay(function()
        local x, y = G.state.player.x, G.state.player.y
        G.state.player:warp(x+45, y+29)
      end, 6)
    end,

    elevator1Up = function()
      closeAndOpenElevatorDoors(1)
      timer:delay(function()
        local x, y = G.state.player.x, G.state.player.y
        G.state.player:warp(x-45, y-29)
      end, 6)
    end,

    elevator2Down = function()
      closeAndOpenElevatorDoors(2)
      timer:delay(function()
        local x, y = G.state.player.x, G.state.player.y
        G.state.player:warp(x-27, y-19)
      end, 6)
    end,

    elevator2Up = function()
      closeAndOpenElevatorDoors(2)
      timer:delay(function()
        local x, y = G.state.player.x, G.state.player.y
        G.state.player:warp(x+27, y+19)
      end, 6)
    end,

    collectHEVSuit = function()
      G.state.level.layers.bottom:set(38, 14, 175)
      G.state.level.layers.ceiling:set(38, 15, 159)
      G.state.level.layers.floor:set(38, 15, 191)
    end,

    openHEVDoor = function ()
      G.state.level.timer:delay(function()
        rotateFreeWall('hevdoorr1', 38.5, 15.375, -1.5708, 1)
        rotateFreeWall('hevdoorr2', 38.5, 15.375, -1.5708, 1)
        rotateFreeWall('hevdoorr3', 38.5, 15.375, -1.5708, 1)
        rotateFreeWall('hevdoorl1', 38.5, 15.375, 1.5708, 1)
        rotateFreeWall('hevdoorl2', 38.5, 15.375, 1.5708, 1)
        rotateFreeWall('hevdoorl3', 38.5, 15.375, 1.5708, 1)
      end, 1)
    end,

    openLockerDoor = function()
      if not lockerdooropen then
        rotateFreeWall('lockerdoor', 45, 20, -1.4, 1)
        lockerdooropen = true
      end
    end,
  }
}

