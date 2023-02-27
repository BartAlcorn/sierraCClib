--[[
  Rednet Broadcast to Turtles for remote control
]]
local tArgs = { ... }
local protocol = tArgs[1]

if #tArgs < 2 then
  print('Usage: broadcast <id|name|group> <command> <argument(s)>')
  return
end

local cmd = ''
local i = 2
while tArgs[i] do
  cmd = cmd .. tArgs[i] .. ' '
  i = i + 1
end

rednet.broadcast(cmd, protocol)
