local cfg = require('configure')
local s9T = require('term')

local function drawHUD(msg)
  local env = cfg.config()
  hasRednet = env.rednet.status

  term.clear()
  term.setCursorPos(1, 1)
  term.write('   ID: ')
  s9T.printColor(env.id, colors.yellow)
  term.setCursorPos(1, 2)
  term.write(' Name: ')
  s9T.printColor(env.label, colors.yellow)
  term.setCursorPos(1, 3)
  term.write('Group: ')
  s9T.printColor((env.group or '-'), colors.yellow)
  term.setCursorPos(1, 4)
  term.write(' Fuel: ')
  s9T.printFuel(env.fuel)
  term.setTextColor(colors.white)

  term.setCursorPos(1, 6)
  if term.isColor() then
    term.setTextColor(colors.blue)
    print(msg or 'by your command...')
    term.setTextColor(colors.white)
  else
    print('your wish, my command...')
  end

  local running = hasRednet

  local w, h = term.getSize()
  term.setTextColor(colors.blue)
  term.clearLine(h)
  term.setCursorPos(1, h)
  term.write(' Q - Quit       R - Refuel')
  term.setTextColor(colors.white)
end

local function drawFuel()
  term.setCursorPos(1, 4)
  term.write(' Fuel: ')
  s9T.printFuel(turtle.getFuelLevel())
end

return {
    drawHUD = drawHUD,
    drawFuel = drawFuel
}
