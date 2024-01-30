local gears            = require('gears')
local dpi              = require('beautiful').xresources.apply_dpi
local gc               = gears.color
local gfs              = gears.filesystem
local color            = require('theme.colorscheme')
local user             = require('config.user')
local helpers          = require('helpers')
local assets_path      = gfs.get_configuration_dir() .. 'theme/assets/'

local _T               = {}

-- Custom Variables
_T.font_sans           = 'Rubik'
_T.font_nerd           = 'Iosevka Nerd Font Mono'
_T.icon                = 'Material-Design-Iconic-Font'
_T.icon_alt            = 'Iosevka Nerd Font Mono'

-- Get the colorscheme
_T.bg_dark             = color.bg_dark
_T.bg_normal           = color.bg_normal
_T.bg_light            = color.bg_light
_T.mid_dark            = color.mid_dark
_T.mid_normal          = color.mid_normal
_T.mid_light           = color.mid_light
_T.fg_dark             = color.fg_dark
_T.fg_normal           = color.fg_normal
_T.fg_light            = color.fg_light
_T.red                 = color.red
_T.red_dark            = color.red_dark
_T.green               = color.green
_T.green_dark          = color.green_dark
_T.yellow              = color.yellow
_T.yellow_dark         = color.yellow_dark
_T.blue                = color.blue
_T.blue_dark           = color.blue_dark
_T.magenta             = color.magenta
_T.magenta_dark        = color.magenta_dark
_T.cyan                = color.cyan
_T.cyan_dark           = color.cyan_dark
_T.transparent         = '#00000000'

-- Basic AWM variables
_T.useless_gap         = dpi(user.gaps)
_T.master_width_factor = 0.56
_T.font                = _T.font_sans .. dpi(10)
_T.icon_theme          = '/home/re1san/.local/share/icons/Reversal-black-dark'
-- Hacky, bad, need to improve this. But doing it this way allows me to send the
-- colors table to other programs.
_T.wallpaper           = user.wallpaper or
		gfs.get_configuration_dir() .. 'theme/colorscheme/' .. user.colorscheme .. '/2.png'
local def_icon         = assets_path .. 'awesome.svg'

if user.avatar ~= nil then
	-- Cropping the image means that the user can use images of arbitrary
	-- aspect ratio, which is very commonly the case.
	local surf = gears.surface.load_uncached(user.avatar)
	_T.awesome_icon = helpers.cropSurface(1, surf)
else
	-- Since we know the default logo IS square, there's no need for cropping.
	_T.awesome_icon = gc.recolor_image(def_icon, _T.fg_normal)
end

-- Logos/icons/avatar
_T.avatar               = user.avatar ~= nil and user.avatar or assets_path .. "deez.jpg"
_T.avatar_lock          = assets_path .. "lock.jpg"
_T.palette              = gc.recolor_image(assets_path .. '/palette/palette.png', _T.fg_normal)
_T.palette_alt          = gc.recolor_image(assets_path .. '/palette/rocket.png', _T.fg_normal)

-- Layout icons
local layouts_path      = assets_path .. 'layout/'
_T.layout_tile          = gc.recolor_image(layouts_path .. 'tile_right.svg', _T.fg_normal)
_T.layout_tileleft      = gc.recolor_image(layouts_path .. 'tile_left.svg', _T.fg_normal)
_T.layout_tilebottom    = gc.recolor_image(layouts_path .. 'tile_bottom.svg', _T.fg_normal)
_T.layout_floating      = gc.recolor_image(layouts_path .. 'float.svg', _T.fg_normal)

-- Yoru's layouts
-- local layouts_path     = assets_path .. 'layout_yoru/'
-- _T.layout_tile       = gc.recolor_image(layouts_path .. 'tile.png',  _T.fg_normal)
-- _T.layout_floating   = gc.recolor_image(layouts_path .. 'floating.png',       _T.fg_normal)

-- Notification
_T.notification_spacing = dpi(16)

-- Snapping
_T.snap_border_width    = dpi(2)
_T.snap_bg              = _T.magneta
_T.snap_shape           = gears.shape.rectangle

-- Titlebar
_T.titlebar_font        = _T.font_sans .. ' Bold'
_T.titlebar_bg_focus    = _T.bg_light
_T.titlebar_fg_focus    = _T.red
_T.titlebar_bg_normal   = _T.bg_normal
_T.titlebar_fg_normal   = _T.bg_light
_T.titlebar_bg_urgent   = _T.red_dark
_T.titlebar_fg_urgent   = _T.mid_normal

-- Taglist
_T.taglist_bg           = _T.bg_normal .. '00'
_T.taglist_bg_focus     = _T.blue
_T.taglist_fg_focus     = _T.fg_normal
_T.taglist_bg_urgent    = _T.red
_T.taglist_fg_urgent    = _T.fg_normal
_T.taglist_bg_occupied  = _T.blue .. '33'
_T.taglist_fg_occupied  = _T.fg_normal
_T.taglist_bg_empty     = _T.blue .. '33'
_T.taglist_fg_empty     = _T.fg_normal
_T.taglist_disable_icon = true

-- Tootip
-- _T.tooltip_border_color	= _T.bg_dark --The tooltip border color.
_T.tooltip_bg           = _T.bg_light  --The tooltip background color.
_T.tooltip_fg           = _T.fg_normal --The tooltip foregound (text) color.
_T.tooltip_font         = _T.font_sans --The tooltip font.
-- _T.tooltip_border_width	= 1 --The tooltip border width.
-- _T.tooltip_opacity	   --The tooltip opacity.
_T.tooltip_shape        = helpers.rrect(dpi(1)) --The default tooltip shape.
-- _T.tooltip_align	--The default tooltip alignment.

-- Music
_T.songdefpicture       = assets_path .. 'defsong.jpg'
_T.songdefpicture_alt   = assets_path .. 'defsong_alt.jpg'

-- Right click menu
_T.menu_font            = _T.font_sans .. 'dpi(8)'
_T.menu_width           = dpi(250)
-- _T.menu_height = dpi(200)
-- _T.menu_border_width = dpi(2)
_T.menu_bg_focus        = _T.bg_light
_T.menu_fg_normal       = _T.fg_normal
_T.menu_bg_normal       = _T.bg_normal

return _T
