--
--  SierraNine Display Utilities
--
local s9T = require('term')
local configure = require('configure')

local function printLine(line, text)
  term.clearLine(6)
  term.setCursorPos(1, 6)
  print('starting up...')
end

local function printAt(row, line, text)
  term.setCursorPos(row, line)
  term.write(text)
end

local function drawHeader()
  env = configure.config()

  local rednetStatus = 'DN'
  if env.rednet ~= nil then rednetStatus = 'UP' end
  printAt(env.w - 10, 1, ' Rednet: ')
  term.setCursorPos(env.w - 1, 1)
  s9T.printStatus(rednetStatus, env.rednet.status)

  if env == nil then
    term.setCursorPos(1, 1)
    term.setTextColor(colors.red)
    term.write('ENV failure.')
    term.setTextColor(colors.white)
  else
    term.setCursorPos(1, 1)
    term.setTextColor(colors.white)
    term.write('   ID: ')
    term.setTextColor(colors.yellow)
    term.write(env.id .. '      ')
    term.setCursorPos(1, 2)
    term.setTextColor(colors.white)
    term.write('Label: ')
    term.setTextColor(colors.yellow)
    term.write(env.label)
    term.setCursorPos(1, 3)
    term.setTextColor(colors.white)
    term.write('Group: ')
    term.setTextColor(colors.yellow)
    term.write(env.group or '-')
    term.setTextColor(colors.white)
    term.setCursorPos(1, 4)
    if turtle then
      term.write(' Fuel: ')
      s9T.printFuel(turtle.getFuelLevel())
      term.setTextColor(colors.white)
    end
    term.setCursorPos(1, 8)
  end

  if env.gps ~= nil then
    term.setCursorPos(env.w - 9, 2)
    if not env.gps.x then
      if env.rednet.status then
        print('    no GPS')
      else
        print('  no modem')
      end
    else
      print('    x: ' .. env.gps.x)
      term.setCursorPos(env.w - 5, 3)
      print('y: ' .. env.gps.y)
      term.setCursorPos(env.w - 5, 4)
      print('z: ' .. env.gps.z)
    end
  else
    term.setCursorPos(env.w - 8, 2)
    term.setTextColor(colors.gray)
    print('don\'t GPS')
    term.setTextColor(colors.white)
  end
end

return {
    printLine = printLine,
    printAt = printAt,
    drawHeader = drawHeader
}
