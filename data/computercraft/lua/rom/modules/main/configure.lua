-- SierraNine ComputerCraft Auto Configure
-- configures a Computer or Turtle and sets label and minimum startup file

local rednetlib = require('rednet')

local function config()
  local env = getEnv()
  local rednet = {}
  rednet.status, rednet.side = rednetlib.hasRednet()
  env.rednet = rednet

  if turtle then
    env.fuel = turtle.getFuelLevel()
  end

  return env
end

local function labeler(env)
  local name = env.type .. env.id .. env.class
  os.setComputerLabel(name)
  return name
end

function getEnv()
  local env = {}
  env.id = os.getComputerID()
  if env.id < 10 then env.id = '0' .. env.id end
  env.class = getClass()
  env.type = getType()
  env.label = os.getComputerLabel()
  if env.label == nil then
    env.label = labeler(env)
  end
  env.w, env.h = term.getSize()
  return env
end

function getClass()
  if term.isColor() then
    return "a"
  end
  return ""
end

function getType()
  if pocket then
    -- is a pocket computer
    return "P"
  elseif turtle and (term.getSize()) == 39 then
    -- is a turtle.
    return "T"
  elseif not turtle and (term.getSize() == 51) then
    -- is a computer.
    return "C"
  else
    -- is a monitor.
    return "M"
  end
end

return {
    config = config,
    labeler = labeler
}
