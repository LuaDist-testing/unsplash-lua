-- Extract current directory name for importing submodules
local cur_dir = (...):gsub('%.[^%.]+$', '')

-- Libraries
local https = require 'ssl.https' -- luasec
local ltn12 = require 'ltn12' -- lua sockets


-- Submodules
local const       = require (cur_dir .. '.constants.index')
local photos      = require (cur_dir .. '.methods.photos')
local search      = require (cur_dir .. '.methods.search')
local stats       = require (cur_dir .. '.methods.stats')
local users       = require (cur_dir .. '.methods.users')
local collections = require (cur_dir .. '.methods.collections')
local categories  = require (cur_dir .. '.methods.categories')
local query       = require (cur_dir .. '.utils.querystring')

local req_headers = {
  ['authorization'] = 'Client-ID ',
  ['Accept-Version'] = 'v1'
}


local function request (req_t)
  local res_t = {}
  local querystring = ''
  local res, code, headers, status

  if req_t.query then
    querystring = query.stringify(req_t.query)
  end

  _,code,headers,status = https.request {
    url = const.API_URL .. req_t.url .. querystring,
    method = req_t.method,
    headers = req_headers,
    sink = ltn12.sink.table(res_t)
  }

  return {
    body = table.concat(res_t),
    header = headers,
    code = code,
    status = status
  }
end


local Unsplash = {}

Unsplash.new = function (app)
  local new = {}

  req_headers.authorization = req_headers.authorization .. (app.applicationId or '')

  new.categories = categories.new(request)
  new.collections = collections.new(request)
  new.photos = photos.new(request)
  new.search = search.new(request)
  new.stats = stats.new(request)
  new.users = users.new(request)
  return new
end

return Unsplash
