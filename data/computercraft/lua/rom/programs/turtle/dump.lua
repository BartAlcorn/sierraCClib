--[[
  DumpInventory - smart inventory dump to enderchest
]]
turtle.select(1)
while turtle.detectUp() do
  turtle.digUp()
end

function isEnderChest()
  if not turtle then print('This function is only usable by Turtles!') end
  turtle.select(1)
  local data = turtle.getItemDetail(1)
  local isEC = false
  if data.name == 'enderstorage:ender_storage' then
    isEC = true
  end
  if data.name == 'multistorage:ender_chest' then
    isEC = true
  end
  -- print ('slot 1 is ' .. data.name)
  return isEC
end

function DumpInventory()
  if not doDump then
    return
  end
  local iLastInventorySlot = 16
  for i = 2, iLastInventorySlot do
    turtle.select(i)
    turtle.dropUp()
  end
  -- chest.setColors(sColors[1],sColors[2],sColors[3])
  turtle.select(1)
  turtle.digUp()
end

doDump = isEnderChest()
if doDump then
  turtle.select(1)
  turtle.placeUp()
  -- chest=peripheral.wrap('top')
  -- local sColors
  -- sColors={1,1,1}
  -- sColors[1],sColors[2],sColors[3]=chest.getColors()
  -- chest.setColors(colors.black,colors.black,colors.black)
  DumpInventory()
end
