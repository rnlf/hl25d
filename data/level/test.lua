local door, doorbasey
local moveDoor = function(yoffset, time)
  local data = {
    y = door.y1
  }
  local moveDoor2 = function()
    door.y1 = data.y
    door.y2 = data.y+1
    G.state.level.freewalls:addFreeWall(door)
  end

  Tween.to(data, time, {y = doorbasey + yoffset})
    :onUpdate(moveDoor2)
end

return {
  map = 'test',
  data = {
    openDoor = function()
      moveDoor(-1, 1)
    end,
    closeDoor = function()
      moveDoor(0, 1)
    end,
    closeDoorFast = function()
      moveDoor(0, 0.2)
    end,
    recttest = function()
      print("Rectangular triggers seem to work, too")
    end,
    init = function()
      door = G.state.level.freewalls:getFreeWall('door1')
      doorbasey = door.y1
    end
  }
}

