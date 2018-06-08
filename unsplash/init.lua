local cur_dir = (...):gsub('%.init$', '') -- "directory"

local Unsplash = require (cur_dir .. '.unsplash')

return Unsplash
