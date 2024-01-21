local gears            = require('gears')

local dpi              = require('beautiful').xresources.apply_dpi
local gc               = gears.color
local gfs              = gears.filesystem

local color            = require('theme.colorscheme')
local user             = require('config.user')
local helper           = require('helpers')

local asset_path       = gfs.get_configuration_dir() .. 'theme/assets/'

local _T               = {}

-- Custom Variables
_T.font_sans           = 'Rubik '
_T.font_mono           = 'IBM Plex Mono '
_T.icon                = 'Material-Design-Iconic-Font'
_T.font_nerd           = 'Iosevka Nerd Font Mono'
_T.font_time           = 'Homenaje'
_T.icon_alt            = 'Iosevka Nerd Font Mono'

-- Custom Colors
_T.bg_light            = color.bg_light
_T.mid_dark            = color.mid_dark
_T.bg_normal           = color.bg_normal
_T.fg_normal           = color.fg_normal
_T.red                 = color.red
_T.red_dark            = color.red_dark
_T.blue                = color.blue
_T.green               = color.green
_T.bg_dark             = color.bg_dark
_T.fg_dark             = color.fg_dark
_T.cyan                = color.cyan
_T.cyan_dark           = color.cyan_dark
_T.yellow_dark         = color.yellow_dark
_T.yellow              = color.yellow
_T.magenta             = color.magenta
_T.magenta_dark        = color.magenta_dark
_T.transparent         = '#00000000'

-- Basic AWM variables
_T.useless_gap         = dpi(user.gaps)
_T.master_width_factor = 0.56
_T.font                = _T.font_sans .. dpi(10)
_T.icon_theme          = '/home/re1san/.local/share/icons/Reversal-black-dark'
-- Hacky, bad, need to improve this. But doing it this way allows me to send the
-- colors table to other programs.
_T.wallpaper           = user.wallpaper or
    gfs.get_configuration_dir() .. 'theme/colorscheme/' .. user.colorscheme .. '/wallpaper.png'

local def_icon         = asset_path .. 'awesome.svg'
if user.avatar ~= nil then
   -- Cropping the image means that the user can use images of arbitrary
   -- aspect ratio, which is very commonly the case.
   local surf = gears.surface.load_uncached(user.avatar)
   _T.awesome_icon = helper.crop_surface(1, surf)
else
   -- Since we know the default logo IS square, there's no need for cropping.
   _T.awesome_icon = gc.recolor_image(def_icon, _T.fg_normal)
end


-- Logos/icons/avatar
_T.nix                  = gc.recolor_image(asset_path .. '/distro/nix_logo.svg', _T.blue)
-- _T.shutdown_icon = gc.recolor_image(asset_path .. '/power/shutdown.svg',_T.red)
_T.shutdown_icon        = gc.recolor_image(asset_path .. '/launcher/power.svg', _T.red)
_T.reboot_icon          = gc.recolor_image(asset_path .. '/launcher/reboot.svg', _T.blue)
_T.lock_icon            = gc.recolor_image(asset_path .. '/launcher/lock.svg', _T.green)
_T.avatar               = user.avatar ~= nil and user.avatar or asset_path .. "user.png"
_T.palette              = gc.recolor_image(asset_path .. '/palette/palette.png', _T.fg_normal)
_T.palette_alt          = gc.recolor_image(asset_path .. '/palette/rocket.png', _T.fg_normal)

-- Systray
_T.bg_systray           = _T.mid_dark
_T.systray_icon_spacing = dpi(4)
-- Layout icons
local icons_path        = asset_path .. 'layout/'
_T.layout_tile          = gc.recolor_image(icons_path .. 'tile_right.svg', _T.fg_normal)
_T.layout_tileleft      = gc.recolor_image(icons_path .. 'tile_left.svg', _T.fg_normal)
_T.layout_tilebottom    = gc.recolor_image(icons_path .. 'tile_bottom.svg', _T.fg_normal)
_T.layout_floating      = gc.recolor_image(icons_path .. 'float.svg', _T.fg_normal)
-- Yoru's layouts
-- local icons_path     = asset_path .. 'layouts/'
-- _T.layout_tile       = gc.recolor_image(icons_path .. 'tile.png',  _T.fg_normal)
-- _T.layout_floating   = gc.recolor_image(icons_path .. 'floating.png',       _T.fg_normal)

-- Snapping
_T.snap_border_width    = dpi(3)
_T.snap_bg              = _T.border_color_marked
_T.snap_shape           = gears.shape.rectangle

-- Notification
_T.notification_spacing = dpi(16)

-- Titlebar
_T.titlebar_font        = _T.font_sans .. "Bold "
_T.titlebar_bg_focus    = _T.bg_light
_T.titlebar_fg_focus    = _T.red
_T.titlebar_bg_normal   = _T.bg_normal
_T.titlebar_fg_normal   = _T.bg_light
_T.titlebar_bg_urgent   = _T.red_dark
_T.titlebar_fg_urgent   = _T.mid_normal

-- Taglist
_T.taglist_bg           = _T.bg_normal .. "00"
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
-- _T.tooltip_border_color	= _T.bg_dark--The tooltip border color.
_T.tooltip_bg           = _T.bg_light  --The tooltip background color.
_T.tooltip_fg           = _T.fg_normal --The tooltip foregound (text) color.
_T.tooltip_font         = _T.font_sans --The tooltip font.
-- _T.tooltip_border_width	= 1 --The tooltip border width.
-- _T.tooltip_opacity	   --The tooltip opacity.
_T.tooltip_shape        = function(c, w, h)
   gears.shape.rounded_rect(c, w, h, dpi(1))
end --The default tooltip shape.
-- _T.tooltip_align	--The default tooltip alignment.

-- Music
_T.songdefpicture       = asset_path .. 'defsong.jpg'
_T.songdefpicture_alt   = asset_path .. 'defsong_alt.jpg'

return _T
