local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local helpers   = require('helpers')
local dpi       = require("beautiful").xresources.apply_dpi
local themer    = require("widgets.themer")

return function()
    local widget = {
        {
            {
                align = 'center',
                widget = wibox.widget.imagebox,
                image = beautiful.palette_alt,
                forced_height = 32,
                forced_width = 32,
                resize = true,
            },
            widget = wibox.container.margin,
            margins = dpi(6)
        },
        widget = wibox.container.background,
        shape = helpers.rrect(2),
        bg = beautiful.bg_light,
        buttons = {
            awful.button({}, 1, function()
                themer:show()
            end)
        },
    }
    return widget
end
