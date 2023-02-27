--
--  smartRefuel -
--
local lowFuelLevel = 100
local s9R = require('rednet')
local s9T = require('term')
local S9U = require('utils')

function isEnderChest()
  turtle.select(1)
  local data = turtle.getItemDetail(1)
  if data then
    return data.name == 'EnderStorage:enderChest'
  else
    term.clear()
    term.setCursorPos(1, 1)
    term.write('NOT an EnderChest')
    return false
  end
end

function refuelEnderChest()
  turtle.select(1)
  turtle.placeUp()

  local sColors
  sColors = { 0, 0, 0 }
  chest = peripheral.wrap('top')
  sColors[1], sColors[2], sColors[3] = chest.getColors()

  chest.setColors(colors.orange, colors.orange, colors.orange)

  turtle.select(16)
  assert(turtle.suckUp(), 'Could not suck more fuel in')
  turtle.refuel()

  chest.setColors(sColors[1], sColors[2], sColors[3])

  turtle.select(1)
  turtle.digUp()
end

function refuelNative()
  --  for i = 1, 16 do
  turtle.select(1)
  turtle.refuel()
  --  end
end

function smartRefuel()
  if turtle.getFuelLevel() <= lowFuelLevel then
    local refueled = false
    s9U.debug('Could not refuel!')

    local data = turtle.getItemDetail(1)
    if data then
      if data.name == 'EnderStorage:enderChest' then
        refuelEnderChest()
        refueled = true
      end
    end

    if not refueled then refuelNative() end

    print('Fuel Level: ' .. turtle.getFuelLevel())

    if turtle.getFuelLevel() > lowFuelLevel then
      return true
    else
      s9U.debug('Could not refuel!')
      return false
    end
  else
    print('Fuel Level: ' .. turtle.getFuelLevel())
  end
end

if turtle.getFuelLevel() < lowFuelLevel then
  if isEnderChest() then
    smartRefuel()
  else
    refuelNative()
  end
end

local id = os.getComputerLabel()
local msg = {}
turtle.refuel()
local fl = turtle.getFuelLevel()
if fl <= lowFuelLevel and fl >= 1 then
  msg['fuel'] = fl
elseif fl == 0 then
  msg['fuel'] = fl
else
  msg['fuel'] = fl
end
s9R.updateCommand(id, msg)
