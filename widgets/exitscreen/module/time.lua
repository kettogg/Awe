local wibox      = require("wibox")
local colors     = require('widgets.exitscreen.module.colors')
local gears      = require('gears')
local beautiful  = require('beautiful')
local dpi        = beautiful.xresources.apply_dpi
local gfs        = gears.filesystem
local asset_path = gfs.get_configuration_dir() .. 'theme/assets/clock/'
local helpers    = require('helpers')

return wibox.widget {

    {
        {
            {
                markup = helpers.colorizeText("󰀠", beautiful.blue),
                font   = beautiful.icon_alt .. " 46",
                align  = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },

            id = "icon_layout",
            widget = wibox.container.place
        },
        {
            font = beautiful.font_sans .. " 14",
            format = "%H:%M",
            align = "center",
            valign = "center",
            widget = wibox.widget.textclock
        },
        spacing = dpi(8),
        layout = wibox.layout.fixed.horizontal
    },
    -- widget = wibox.container.background,
    -- bg = beautiful.bg_normal,
    widget = wibox.container.place,
    valign = "center"
}
