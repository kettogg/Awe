local beautiful     = require('beautiful')
local theme_assets  = require('beautiful.theme_assets')
local dpi           = require('beautiful.xresources').apply_dpi
local rnotification = require('ruled.notification')
local gfs           = require('gears.filesystem')
local user          = require('config.user')
local asset_path    = gfs.get_configuration_dir() .. 'theme/assets/'
local def_assets    = asset_path .. 'default/'

local colors        = require('theme.colorscheme').colors
local _T            = {}

_T.sans             = 'Satoshi 11'
_T.nerd             = 'Iosevka NF'
_T.term             = 'Iosevka NFM'
_T.wallpaper        = require('theme.colorscheme').wallpaper
_T.icon_theme       = user.icons

-- Attach colors to _T
_T.bg_dark          = colors.bg_dark
_T.bg_normal        = colors.bg_normal
_T.bg_light         = colors.bg_light
_T.mid_dark         = colors.mid_dark
_T.mid_normal       = colors.mid_normal
_T.mid_light        = colors.mid_light
_T.fg_dark          = colors.fg_dark
_T.fg_normal        = colors.fg_normal
_T.fg_light         = colors.fg_light
_T.red              = colors.red
_T.red_dark         = colors.red_dark
_T.green            = colors.green
_T.green_dark       = colors.green_dark
_T.yellow           = colors.yellow
_T.yellow_dark      = colors.yellow_dark
_T.blue             = colors.blue
_T.blue_dark        = colors.blue_dark
_T.magenta          = colors.magenta
_T.magenta_dark     = colors.magenta_dark
_T.cyan             = colors.cyan
_T.cyan_dark        = colors.cyan_dark


_T.font                                      = _T.sans
_T.bg_normal                                 = _T.bg_normal
_T.bg_focus                                  = _T.bg_light
_T.bg_urgent                                 = _T.red
_T.bg_minimize                               = _T.bg_light
_T.bg_systray                                = _T.bg_normal

_T.fg_normal                                 = _T.fg_normal
_T.fg_focus                                  = _T.fg_light
_T.fg_urgent                                 = _T.fg_light
_T.fg_minimize                               = _T.fg_light

_T.useless_gap                               = dpi(0)
_T.border_width                              = dpi(1)
_T.border_color_normal                       = _T.bg_normal
_T.border_color_active                       = _T.mid_normal
_T.border_color_marked                       = _T.red

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
_T.taglist_bg_focus                          = _T.cyan
_T.taglist_fg_focus                          = _T.bg_normal

-- Generate taglist squares:
local taglist_square_size                    = dpi(4)
_T.taglist_squares_sel                       = theme_assets.taglist_squares_sel(taglist_square_size, _T.fg_normal)
_T.taglist_squares_unsel                     = theme_assets.taglist_squares_unsel(taglist_square_size, _T.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
_T.menu_submenu_icon                         = def_assets .. 'submenu.png'
_T.menu_height                               = dpi(15)
_T.menu_width                                = dpi(100)

_T.awesome_icon                              = theme_assets.awesome_icon(_T.menu_height, _T.fg_focus, _T.bg_focus)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--_T.bg_widget = '#cc0000'

-- Define the image to load
_T.titlebar_close_button_normal              = def_assets .. 'titlebar/close_normal.png'
_T.titlebar_close_button_focus               = def_assets .. 'titlebar/close_focus.png'

_T.titlebar_minimize_button_normal           = def_assets .. 'titlebar/minimize_normal.png'
_T.titlebar_minimize_button_focus            = def_assets .. 'titlebar/minimize_focus.png'

_T.titlebar_ontop_button_normal_inactive     = def_assets .. 'titlebar/ontop_normal_inactive.png'
_T.titlebar_ontop_button_focus_inactive      = def_assets .. 'titlebar/ontop_focus_inactive.png'
_T.titlebar_ontop_button_normal_active       = def_assets .. 'titlebar/ontop_normal_active.png'
_T.titlebar_ontop_button_focus_active        = def_assets .. 'titlebar/ontop_focus_active.png'

_T.titlebar_sticky_button_normal_inactive    = def_assets .. 'titlebar/sticky_normal_inactive.png'
_T.titlebar_sticky_button_focus_inactive     = def_assets .. 'titlebar/sticky_focus_inactive.png'
_T.titlebar_sticky_button_normal_active      = def_assets .. 'titlebar/sticky_normal_active.png'
_T.titlebar_sticky_button_focus_active       = def_assets .. 'titlebar/sticky_focus_active.png'

_T.titlebar_floating_button_normal_inactive  = def_assets .. 'titlebar/floating_normal_inactive.png'
_T.titlebar_floating_button_focus_inactive   = def_assets .. 'titlebar/floating_focus_inactive.png'
_T.titlebar_floating_button_normal_active    = def_assets .. 'titlebar/floating_normal_active.png'
_T.titlebar_floating_button_focus_active     = def_assets .. 'titlebar/floating_focus_active.png'

_T.titlebar_maximized_button_normal_inactive = def_assets .. 'titlebar/maximized_normal_inactive.png'
_T.titlebar_maximized_button_focus_inactive  = def_assets .. 'titlebar/maximized_focus_inactive.png'
_T.titlebar_maximized_button_normal_active   = def_assets .. 'titlebar/maximized_normal_active.png'
_T.titlebar_maximized_button_focus_active    = def_assets .. 'titlebar/maximized_focus_active.png'

-- You can use your own layout icons like this:
_T.layout_fairh                              = def_assets .. 'layouts/fairhw.png'
_T.layout_fairv                              = def_assets .. 'layouts/fairvw.png'
_T.layout_floating                           = def_assets .. 'layouts/floatingw.png'
_T.layout_magnifier                          = def_assets .. 'layouts/magnifierw.png'
_T.layout_max                                = def_assets .. 'layouts/maxw.png'
_T.layout_fullscreen                         = def_assets .. 'layouts/fullscreenw.png'
_T.layout_tilebottom                         = def_assets .. 'layouts/tilebottomw.png'
_T.layout_tileleft                           = def_assets .. 'layouts/tileleftw.png'
_T.layout_tile                               = def_assets .. 'layouts/tilew.png'
_T.layout_tiletop                            = def_assets .. 'layouts/tiletopw.png'
_T.layout_spiral                             = def_assets .. 'layouts/spiralw.png'
_T.layout_dwindle                            = def_assets .. 'layouts/dwindlew.png'
_T.layout_cornernw                           = def_assets .. 'layouts/cornernww.png'
_T.layout_cornerne                           = def_assets .. 'layouts/cornernew.png'
_T.layout_cornersw                           = def_assets .. 'layouts/cornersww.png'
_T.layout_cornerse                           = def_assets .. 'layouts/cornersew.png'


-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule({
        rule = { urgency = 'critical' },
        properties = { bg = _T.red, fg = _T.fg_normal },
    })
end)

_T.hotkeys_border_color = colors.mid_normal
-- beautiful.hotkeys_bg 	Hotkeys widget background color.
-- beautiful.hotkeys_fg 	Hotkeys widget foreground color.
-- beautiful.hotkeys_border_width 	Hotkeys widget border width.
-- beautiful.hotkeys_border_color 	Hotkeys widget border color.
-- beautiful.hotkeys_shape 	Hotkeys widget shape.
-- beautiful.hotkeys_modifiers_fg 	Foreground color used for hotkey modifiers (Ctrl, Alt, Super, etc).
-- beautiful.hotkeys_label_bg 	Background color used for miscellaneous labels of hotkeys widget.
-- beautiful.hotkeys_label_fg 	Foreground color used for hotkey groups and other labels.
_T.hotkeys_font = _T.nerd .. ' Bold 13'                    -- Main hotkeys widget font.
_T.hotkeys_description_font = _T.nerd .. ' Thin Italic 12' -- Font used for hotkeys' descriptions.
-- beautiful.hotkeys_group_margin
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

return _T
