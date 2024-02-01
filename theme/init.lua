local beautiful = require('beautiful')
local gears     = require('gears')
local gfs       = gears.filesystem
local user      = require('config.user')

beautiful.init(gfs.get_configuration_dir() .. 'theme/colorscheme/' .. (user.colorscheme or 'default') .. '/theme.lua')
