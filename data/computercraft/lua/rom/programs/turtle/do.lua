--
--  do - give shell access to all turtle commands
--
local hud = require('turtlehud')

local tArgs = { ... }
local result = 'Ok'
local cmd = {}

hud.drawHUD(tArgs[1])

-- cmd.getCount = function(tArgs)
--   if #tArgs > 1 then
--     return tonumber(tArgs[2])
--   else
--     return 1
--   end
-- end

cmd.reverse = function()
  turtle.turnRight()
  turtle.turnRight()
  hud.drawFuel()
  return 'Ok'
end

cmd.refuel = function()
  local limit = turtle.getFuelLimit()
  local level = turtle.getFuelLevel()
  for i = 1, 16 do
    turtle.select(i)
    turtle.refuel(turtle.getItemCount(i))
  end
  return 'Refuel: ' .. turtle.getFuelLevel()
end

cmd.left = function()
  turtle.turnLeft()
  hud.drawFuel()
  return 'Ok'
end

cmd.right = function()
  turtle.turnRight()
  hud.drawFuel()
  return 'Ok'
end

cmd.shiftLeft = function()
  turtle.turnLeft()
  cmd.forward()
  turtle.turnRight()
  hud.drawFuel()
  return 'Ok'
end

cmd.shiftRight = function()
  turtle.turnRight()
  cmd.forward()
  turtle.turnLeft()
  hud.drawFuel()
  return 'Ok'
end

cmd.up = function()
  local count = tonumber(tArgs[2]) or 1
  for i = 1, count do
    while turtle.detectUp() do turtle.digUp() end
    turtle.up()
    hud.drawFuel()
  end
  return 'Ok'
end

cmd.down = function()
  local count = tonumber(tArgs[2]) or 1
  for i = 1, count do
    while turtle.detectDown() do turtle.digDown() end
    turtle.down()
    hud.drawFuel()
  end
  return 'Ok'
end

cmd.forward = function()
  local count = tonumber(tArgs[2]) or 1
  for i = 1, count do
    while turtle.detect() do
      local dig = true
      local success, data = turtle.inspect()
      if success then
        print(data.name)
        if data.name == 'ComputerCraft:CC-Turtle' or data.name ==
            'ComputerCraft:CC-TurtleAdvanced' then
          dig = false
          return 'Another turtle is blocking forward'
        end
      end
      if dig then turtle.dig() end
    end
    turtle.forward()
    hud.drawFuel()
  end
  return 'Ok'
end

cmd.back = function()
  local count = tonumber(tArgs[2]) or 1
  for i = 1, count do
    turtle.back()
    hud.drawFuel()
    hud.drawFuel()
  end
  return 'Ok'
end

cmd.dig = function() return turtle.dig() end

cmd.digDown = function()
  turtle.digDown()
  return 'Ok'
end

cmd.digUp = function()
  while turtle.digUp() do
    hud.drawFuel()
  end
  return 'Ok'
end

cmd.place = function() return turtle.place() end

cmd.placeUp = function() return turtle.placeUp() end

cmd.placeDown = function() return turtle.placeDown() end

cmd.drop = function() return turtle.drop() end

cmd.dropDown = function() return turtle.dropDown() end

cmd.dropUp = function() return turtle.dropUp() end

cmd.select = function()
  local count = tonumber(tArgs[2]) or 1
  turtle.select(count)
  return 'Ok'
end

cmd.suck = function() return turtle.suck() end

cmd.suckDown = function() return turtle.suckDown() end

cmd.suckUp = function() return turtle.suckUp() end

result = cmd[tArgs[1]]()
return result
