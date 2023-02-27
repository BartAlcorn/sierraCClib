--
-- standard melee turtle script
--
local s9R = require('rednet')
local s9T = require('term')
local configure = require('configure')
local hud = require('turtlehud')

local env = configure.config()
assert(turtle, 'This is a TURTLE ONLY app! :/')

function doMessage(msg)
  id = msg[2]
  message = msg[3]
  protocol = msg[4]

  if id == myID or protocol == myName or protocol == myGroup or protocol ==
      'turtles' then
    term.clearLine(8)
    term.setCursorPos(1, 8)
    result = shell.run('smartrefuel')
    term.clearLine(6)
    term.setCursorPos(1, 6)
    print(message)
    local id = os.getComputerLabel()
    local msg = { status = message .. ': running' }
    msg['fuel'] = turtle.getFuelLevel()
    s9R.updateCommand(id, msg)
    result = shell.run(message)
    msg = { status = message .. ': ' .. tostring(result) }
    msg['fuel'] = turtle.getFuelLevel()
    s9R.updateCommand(id, msg)
  end
end

hud.drawHUD()
running = env.rednet.status

if running then
  while true do
    event = { os.pullEvent() }
    if event[1] == 'rednet_message' then
      doMessage(event)
    elseif event[1] == 'key' then
      if event[2] == keys.q then
        running = false;
        break
      elseif event[2] == keys.r then
        shell.run('smartrefuel')
      end
    end
  end
end

term.setCursorPos(1, 1)
term.clear()
