local beautiful         = require('beautiful')
local theme_assets      = require('beautiful.theme_assets')
local dpi               = require('beautiful.xresources').apply_dpi
local rnotification     = require('ruled.notification')
local gfs               = require('gears.filesystem')
local user              = require('config.user')
local helpers           = require('helpers')

local asset_path        = gfs.get_configuration_dir() .. 'theme/assets/'
local feather           = asset_path .. 'feather/'
local colors            = require('theme.colorscheme').colors
local _T                = {}

_T.sans                 = 'Satoshi 11'
_T.nerd                 = 'Iosevka NF'
_T.term                 = 'Fairfax'
_T.wallpaper            = require('theme.colorscheme').wallpaper
_T.icon_theme           = user.icons

-- Attach colors to _T
_T.bg_dark              = colors.bg_dark
_T.bg_normal            = colors.bg_normal
_T.bg_light             = colors.bg_light
_T.mid_dark             = colors.mid_dark
_T.mid_normal           = colors.mid_normal
_T.mid_light            = colors.mid_light
_T.fg_dark              = colors.fg_dark
_T.fg_normal            = colors.fg_normal
_T.fg_light             = colors.fg_light
_T.red                  = colors.red
_T.red_dark             = colors.red_dark
_T.green                = colors.green
_T.green_dark           = colors.green_dark
_T.yellow               = colors.yellow
_T.yellow_dark          = colors.yellow_dark
_T.blue                 = colors.blue
_T.blue_dark            = colors.blue_dark
_T.magenta              = colors.magenta
_T.magenta_dark         = colors.magenta_dark
_T.cyan                 = colors.cyan
_T.cyan_dark            = colors.cyan_dark
_T.transparent          = '#00000000'
_T.accent               = _T.cyan

_T.font                 = _T.nerd

_T.bg_normal            = _T.bg_normal
_T.bg_focus             = _T.bg_light

_T.bg_urgent            = _T.red
_T.bg_minimize          = _T.bg_light
_T.bg_systray           = _T.bg_normal
_T.wibar_bg             = _T.bg_normal

_T.fg_normal            = _T.fg_normal
_T.fg_focus             = _T.fg_light
_T.fg_urgent            = _T.fg_light
_T.fg_minimize          = _T.fg_light

_T.useless_gap          = dpi(0)
_T.border_width         = dpi(1)
_T.border_color_normal  = _T.mid_normal
_T.border_color_active  = _T.mid_normal
_T.border_color_marked  = _T.red

-- Taglist
_T.taglist_bg_focus     = _T.cyan
_T.taglist_fg_focus     = _T.fg_normal
_T.taglist_bg_urgent    = _T.red
_T.taglist_fg_urgent    = _T.fg_normal
_T.taglist_bg_occupied  = _T.fg_dark
_T.taglist_fg_occupied  = _T.fg_normal
_T.taglist_bg_empty     = _T.mid_normal
_T.taglist_fg_empty     = _T.fg_normal
_T.taglist_disable_icon = true

-- Tasklist
-- Defined in theme/ui/wibar/module/tasklist

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
_T.menu_submenu_icon    = helpers.recolorImage(asset_path .. 'submenu-pad.png', _T.fg_normal)
_T.menu_height          = dpi(40)
_T.menu_width           = dpi(196)

-- For Notifications
_T.awesome_icon         = helpers.recolorImage(asset_path .. 'awesome.svg', _T.fg_normal)
_T.notification_default = _T.awesome_icon
_T.notification_cancel  = helpers.recolorImage(asset_path .. 'awesome.svg', _T.red)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--_T.bg_widget = '#cc0000'

-- Titlebar
_T.close_butt           = feather .. 'x.svg'
_T.minimize_butt        = feather .. 'minimize.svg'
_T.command_butt         = feather .. 'command.svg'
_T.expand_butt          = feather .. 'expand.svg'
_T.unexpand_butt        = feather .. 'unexpand.svg'
_T.titlebar_bg_normal   = _T.bg_light
_T.titlebar_bg_focus    = _T.bg_light
_T.titlebar_bg_urgent   = _T.bg_light

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
	rnotification.append_rule({
		rule = { urgency = 'critical' },
		properties = { bg = _T.red, fg = _T.fg_normal },
	})
end)

_T.hotkeys_border_color     = _T.mid_normal
-- beautiful.hotkeys_bg 	Hotkeys widget background color.
_T.hotkeys_fg               = _T.fg_normal -- Hotkeys widget foreground color.
-- beautiful.hotkeys_border_width 	Hotkeys widget border width.
-- beautiful.hotkeys_border_color 	Hotkeys widget border color.
-- beautiful.hotkeys_shape 	Hotkeys widget shape.
_T.hotkeys_modifiers_fg     = _T.mid_light -- Foreground color used for hotkey modifiers (Ctrl, Alt, Super, etc).
-- beautiful.hotkeys_label_bg 	Background color used for miscellaneous labels of hotkeys widget.
-- beautiful.hotkeys_label_fg 	Foreground color used for hotkey groups and other labels.
_T.hotkeys_font             = _T.nerd              -- Main hotkeys widget font.
_T.hotkeys_description_font = _T.nerd .. ' Italic' -- Font used for hotkeys' descriptions.
-- beautiful.hotkeys_group_margin
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

-- Snap rectangles that appear when you move your client near screen edge
_T.snap_bg                  = _T.red
_T.snap_border_width        = dpi(2)
_T.snap_shape               = helpers.rrect(0)

return _T
