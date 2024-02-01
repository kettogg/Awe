local theme_assets                          = require('beautiful.theme_assets')
local dpi                                   = require('beautiful.xresources').apply_dpi
local rnotification                         = require('ruled.notification')
local gfs                                   = require('gears.filesystem')
local def_assets                            = gfs.get_configuration_dir() .. 'theme/assets/default/'
local wall_dir                              = gfs.get_configuration_dir() .. 'theme/colorscheme/oxocarbon/'
local T                                     = {}

T.font                                      = 'sans 12'

T.bg_normal                                 = '#222222'
T.bg_focus                                  = '#535d6c'
T.bg_urgent                                 = '#ff0000'
T.bg_minimize                               = '#444444'
T.bg_systray                                = T.bg_normal

T.fg_normal                                 = '#aaaaaa'
T.fg_focus                                  = '#ffffff'
T.fg_urgent                                 = '#ffffff'
T.fg_minimize                               = '#ffffff'

T.useless_gap                               = dpi(0)
T.border_width                              = dpi(1)
T.border_color_normal                       = '#000000'
T.border_color_active                       = '#535d6c'
T.border_color_marked                       = '#91231c'

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
--T.taglist_bg_focus = '#ff0000'

-- Generate taglist squares:
local taglist_square_size                   = dpi(4)
T.taglist_squares_sel                       = theme_assets.taglist_squares_sel(
	taglist_square_size, T.fg_normal
)
T.taglist_squares_unsel                     = theme_assets.taglist_squares_unsel(
	taglist_square_size, T.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
T.menu_submenu_icon                         = def_assets .. 'submenu.png'
T.menu_height                               = dpi(15)
T.menu_width                                = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--T.bg_widget = '#cc0000'

-- Define the image to load
T.titlebar_close_button_normal              = def_assets .. 'titlebar/close_normal.png'
T.titlebar_close_button_focus               = def_assets .. 'titlebar/close_focus.png'

T.titlebar_minimize_button_normal           = def_assets .. 'titlebar/minimize_normal.png'
T.titlebar_minimize_button_focus            = def_assets .. 'titlebar/minimize_focus.png'

T.titlebar_ontop_button_normal_inactive     = def_assets .. 'titlebar/ontop_normal_inactive.png'
T.titlebar_ontop_button_focus_inactive      = def_assets .. 'titlebar/ontop_focus_inactive.png'
T.titlebar_ontop_button_normal_active       = def_assets .. 'titlebar/ontop_normal_active.png'
T.titlebar_ontop_button_focus_active        = def_assets .. 'titlebar/ontop_focus_active.png'

T.titlebar_sticky_button_normal_inactive    = def_assets .. 'titlebar/sticky_normal_inactive.png'
T.titlebar_sticky_button_focus_inactive     = def_assets .. 'titlebar/sticky_focus_inactive.png'
T.titlebar_sticky_button_normal_active      = def_assets .. 'titlebar/sticky_normal_active.png'
T.titlebar_sticky_button_focus_active       = def_assets .. 'titlebar/sticky_focus_active.png'

T.titlebar_floating_button_normal_inactive  = def_assets .. 'titlebar/floating_normal_inactive.png'
T.titlebar_floating_button_focus_inactive   = def_assets .. 'titlebar/floating_focus_inactive.png'
T.titlebar_floating_button_normal_active    = def_assets .. 'titlebar/floating_normal_active.png'
T.titlebar_floating_button_focus_active     = def_assets .. 'titlebar/floating_focus_active.png'

T.titlebar_maximized_button_normal_inactive = def_assets .. 'titlebar/maximized_normal_inactive.png'
T.titlebar_maximized_button_focus_inactive  = def_assets .. 'titlebar/maximized_focus_inactive.png'
T.titlebar_maximized_button_normal_active   = def_assets .. 'titlebar/maximized_normal_active.png'
T.titlebar_maximized_button_focus_active    = def_assets .. 'titlebar/maximized_focus_active.png'



-- You can use your own layout icons like this:
T.layout_fairh      = def_assets .. 'layouts/fairhw.png'
T.layout_fairv      = def_assets .. 'layouts/fairvw.png'
T.layout_floating   = def_assets .. 'layouts/floatingw.png'
T.layout_magnifier  = def_assets .. 'layouts/magnifierw.png'
T.layout_max        = def_assets .. 'layouts/maxw.png'
T.layout_fullscreen = def_assets .. 'layouts/fullscreenw.png'
T.layout_tilebottom = def_assets .. 'layouts/tilebottomw.png'
T.layout_tileleft   = def_assets .. 'layouts/tileleftw.png'
T.layout_tile       = def_assets .. 'layouts/tilew.png'
T.layout_tiletop    = def_assets .. 'layouts/tiletopw.png'
T.layout_spiral     = def_assets .. 'layouts/spiralw.png'
T.layout_dwindle    = def_assets .. 'layouts/dwindlew.png'
T.layout_cornernw   = def_assets .. 'layouts/cornernww.png'
T.layout_cornerne   = def_assets .. 'layouts/cornernew.png'
T.layout_cornersw   = def_assets .. 'layouts/cornersww.png'
T.layout_cornerse   = def_assets .. 'layouts/cornersew.png'

-- Generate Awesome icon:
T.awesome_icon      = theme_assets.awesome_icon(
	T.menu_height, T.bg_focus, T.fg_focus
)

-- Wallpaper
T.wallpaper         = wall_dir .. 'wall.jpg'

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
T.icon_theme        = '/usr/share/icons/Zafiro-Icons-Dark'

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
	rnotification.append_rule {
		rule       = { urgency = 'critical' },
		properties = { bg = '#ff0000', fg = '#ffffff' }
	}
end)

return T

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
