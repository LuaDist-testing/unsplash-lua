local query = {}


local function comma_separated_query(t)
  local result = ""
  for k, v in pairs(t) do
    result = result .. tostring(v) .. ","
  end
  return (result:sub(1, - 2))
end

query.stringify = function (q)
  local result = '?'

  for name, value in pairs(q) do
    if name == "collections" or name == "rectangle" then
      result = result .. tostring(name) .. '=' .. comma_separated_query(value) .. '&'
    else
      result = result .. tostring(name) .. '=' .. tostring(value) .. '&'
    end
  end

  return result:sub(1, - 2)
end

--[[
When doing a request with a query the url will look like
url/path/to/resource?query1=1&...
--]]
return query
