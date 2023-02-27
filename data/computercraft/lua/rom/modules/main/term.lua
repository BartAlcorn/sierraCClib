--[[
    SierraNine Term Utilities
]]
function partitionWindow()
  local w, h = term.current().getSize()

  local status = window.create(term.current(), 1, 1, w, 4)
  if term.isColor() then
    status.setBackgroundColor(colors.white)
    status.setTextColor(colors.blue)
  end
  status.clear()
  status.setCursorPos(1, 1)

  local screen = window.create(term.current(), 1, 5, w, h - 4)
  if term.isColor() then
    screen.setBackgroundColor(colors.blue)
    screen.setTextColor(colors.white)
  end
  screen.clear()
  screen.setCursorPos(1, 1)

  result = {}
  result['status'] = status
  result['screen'] = screen
  return result
end

printColor = function(msg, clr)
  if term.isColor() then
    local current = term.getTextColor()
    term.setTextColor(clr)
    term.write(msg)
    term.setTextColor(current)
  else
    term.write(msg)
  end
end

printStatus = function(statusStr, statusBool)
  if term.isColor() then
    local current = term.getTextColor()
    if statusBool then
      term.setTextColor(colors.green)
    else
      term.setTextColor(colors.green)
    end
    term.write(statusStr)
    term.setTextColor(current)
  else
    term.write(statusStr)
  end
end

printFuel = function(fuel)
  if term.isColor() then
    local currentF = term.getTextColor()
    local currentB = term.getBackgroundColor()
    local x, y = term.getCursorPos()
    term.write(string.rep(' ', 6))
    term.setCursorPos(x, y)
    if fuel == 0 then
      term.setTextColor(colors.red)
    elseif fuel <= 100 then
      term.setTextColor(colors.orange)
    else
      term.setTextColor(colors.white)
    end
    print(fuel)
    term.setTextColor(currentF)
    term.setBackgroundColor(currentB)
  else
    term.write(fuel)
  end
end

return {
    partitionWindow = partitionWindow,
    printColor = printColor,
    printStatus = printStatus,
    printFuel = printFuel
}
