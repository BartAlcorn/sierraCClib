--[[
  SierraNine Rednet Utilities
]]
hasRednet = function()
  local result = {}
  result.status = false
  for _, side in pairs(redstone.getSides()) do
    if peripheral.getType(side) == "modem" then
      rednet.open(side)
      return true, side
    end
  end
  return false, "back"
end

doGPS = function(name)
  local request = 'http://localhost:8080/' .. name .. '/gps/'
  local data = http.get(request)
  if data then
    local t = json.decode(data.readAll())
    return t
  else
    return false
  end
end

toggleGPS = function(name)
  local request = 'http://localhost:8080/' .. name .. '/gps/toggle/'
  local data = http.get(request)
  if data then
    local t = json.decode(data.readAll())
    return t
  else
    return false
  end
end

updateCommand = function(id, payload)
  local msg = {}
  msg[id] = payload
  rednet.broadcast(textutils.serialize(msg), 'command')
end

return {
    hasRednet = hasRednet,
    doGPS = doGPS,
    toggleGPS = toggleGPS,
    updateCommand = updateCommand
}
