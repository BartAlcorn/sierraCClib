print("Using my fancy datapack!")
-- @name autorun
-- @description configures any CC computer or turtle
-- @author SierraNine

local display = require('display')
local config = require('configure')

local env = config.config()

display.printLine(3, 'starting up...')

if turtle then
  shell.run('turtlemain')
end

if pocket then
  term.clear()
  display.drawHeader()
end
