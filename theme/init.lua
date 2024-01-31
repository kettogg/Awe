local dpi         = require('beautiful').xresources.apply_dpi
local gears       = require('gears')
local gfs         = gears.filesystem
local user        = require('config.user')
local colors_path = gfs.get_configuration_dir() .. 'theme/colors/' .. user.colorscheme

local M          = {}

M.sans           = 'Rubik'
M.wallpaper      = user.wallpaper or colors_path .. '/wall.jpg'

return M
