-- floormaker
--[[
  @author:        SierraNine
  @description:   replaces block below turtle with dirt
]]
local tArgs = { ... }
if #tArgs < 1 then
  print('Usage: floormaker <length>')
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
  print('Floor making length must be positive')
  return
end

local ff = true -- FacingForward
for i = 1, length do
  local check, belowme = turtle.inspectDown() --# will get the block name and the metadata
  if check and (belowme.name == "minecraft:grass") or (belowme.name == "minecraft:dirt") then --#belowme.name comes back to what ever is belowme so for dirt it would be "minecraft:dirt"
    while turtle.detect() do
      turtle.dig()
    end
    turtle.forward()
  else
    turtle.digDown()
    turtle.placeDown()
    turtle.forward()
  end
  os.sleep(.3)
end


if doDump then
  shell.run('dump')
end
