--[[
  SierraNine General Utilities
]]
function debug(str, line)
  local x, y
  x, y = term.getCursorPos()
  if line == nil then
    term.setCursorPos(1, y)
    term.clearLine(y)
    term.write(tostring(str))
    term.setCursorPos(x, y + 1)
    return true
  else
    term.setCursorPos(1, line)
    term.clearLine(line)
    term.write(tostring(str))
    term.setCursorPos(x, y)
    return true
  end
end

function doOnce(func, ...)
  local ret
  local thisFunc = tostring(func)
  if func == nil then
    temp[thisFunc] = false
    return true
  end

  if not temp[thisFunc] then ret = func(unpack(arg)) end
  temp[thisFunc] = true
  return ret
end

--[[ Array ( 'table' in lua ) Functions ]]
function sortTable(myTable)
  local keys = {}
  for k, v in pairs(myTable) do table.insert(keys, k) end
  table.sort(keys)
  local result = {}
  for i = 1, #keys do result[keys[i]] = myTable[keys[i]] end
  return result
end

function arrayAdd(array, item)
  if type(array) ~= "table" then
    return { item }
  else
    array[#array + 1] = item
    return array
  end
end

function arraySearch(array, search)
  for i, v in pairs(array) do if v == search then return i end end
  return false
end

function arrayPrint(array, recursive, indentation)
  if indentation == nil then indentation = 0 end
  for i, v in pairs(array) do
    if type(v) == "table" and recursive then
      arrayPrint(v, true, indentation + 1)
    else
      print(string.rep("  ", indentation) .. "'" .. tostring(v) .. "'")
    end
  end
end

function tableToString(array)
  if type(array) == "table" then
    return string.gsub(textutils.serialize(array), "\n", "")
  else
    assert(false)
  end
end

function stringToTable(str)
  if type(str) == "string" then
    return textutils.unserialize(str)
  else
    return false
  end
end

function isTurtle(item)
  return item and (item.name == 'ComputerCraft:CC-Turtle' or item.name ==
      'ComputerCraft:CC-TurtleExpanded' or item.name ==
      'ComputerCraft:CC-TurtleAdvanced')
end

--[[  ]]
function getComputerType()
  local cType = ""
  local cTypeLong = ""
  local cID = os.getComputerID()
  local cClass = ""
  local cClassLong = ""

  if pocket then
    -- is a pocket computer
    cType = "P"
    cTypeLong = "pocket"
  elseif turtle and (term.getSize()) == 39 then
    -- is a turtle.
    cType = "T"
    cTypeLong = "turtle"
  elseif not turtle and (term.getSize() == 51) then
    -- is a computer.
    cType = "C"
    cTypeLong = "computer"
  else
    -- is a monitor.
    cType = "M"
    cTypeLong = "monitor"
  end

  if term.isColor() then
    -- # if it's an advanced computer
    cClass = "a"
    cClassLong = 'advanced'
  else
    -- # if it's a normal computer
    cClass = ""
    cClassLong = "basic"
  end

  if cID < 10 then cID = '0' .. cID end
  local cLabel = cType .. cID .. cClass
  os.setComputerLabel(cLabel)
  local result = {}
  result['label'] = cLabel
  result['type'] = cType
  result['typeLong'] = cTypeLong
  result['ID'] = cID
  result['class'] = cClass
  result['classLong'] = cClassLong
  result['group'] = "-"
  return result
end

return {
    debug = debug,
    doOnce = doOnce,
    sortTable = sortTable,
    arrayAdd = arrayAdd,
    arraySearch = arraySearch,
    arrayPrint = arrayPrint,
    tableToString = tableToString,
    stringToTable = stringToTable,
    getComputerType = getComputerType
}
