-- stripper
--[[
  @author:      SierraNine
  @description: mine a single strip 3 high (above and below current level) for n distance
                if enderchest / tesseract / dimensional transceiver is present in slot one, dump up
]]
local tArgs = { ... }
if #tArgs < 1 then
  print('Usage: stripper <length> row<defaults: 1> --down')
  return
end

doDump = false
if turtle.getItemCount(1) > 0 then
  local data = turtle.getItemDetail(slot)
  if data ~= nil then
    if data.name == 'enderstorage:ender_storage' then
      doDump = true
    end
    if data.name == 'multistorage:ender_chest' then
      doDump = true
    end
  end
end

local length = tonumber(tArgs[1])
if length < 1 then
  print('Strip Mining length must be positive')
  return
end

local rows = tonumber(tArgs[2]) or 1
if rows < 1 then
  print('Strip Mining rows must be positive')
  return
end

local vert = 'up'
if tArgs[3] and tArgs[3] == '--down' then vert = 'dn' end

local howFar = 0
local ff = true -- FacingForward
for r = 1, rows do
  for i = 1, length do
    turtle.digUp()
    turtle.digDown()
    while turtle.detect() do
      turtle.dig()
    end
    if turtle.forward() then
      howFar = howFar + 1
    end
    while turtle.detectUp() do
      turtle.digUp()
      os.sleep(.3)
    end
    turtle.digDown()
    if turtle.getItemCount(15) >= 1 then
      if doDump then
        print('~ dumping Inventory.')
        shell.run('dump')
      else
        print('~ inventory full... \nStopping after ' .. howFar .. ' meters.')
        return
      end
    end
  end
  if rows > r then
    for u = 1, 3 do
      if vert == 'up' then
        while turtle.detectUp() do
          turtle.digUp()
        end
        turtle.up()
      else
        turtle.digDown()
        turtle.down()
      end
    end
    turtle.digDown()
    turtle.turnRight()
    turtle.turnRight()
    ff = not ff
  end
end

if rows > 1 then
  for u = 1, ((rows - 1) * 3) do
    if vert == 'up' then
      turtle.digDown()
      turtle.down()
    else
      while turtle.detectUp() do
        turtle.digUp()
      end
      turtle.up()
    end
  end
end

if not ff then
  turtle.turnRight()
  turtle.turnRight()
end

if doDump then
  shell.run('dump')
end
