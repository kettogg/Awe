local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local helpers   = require("helpers")

return function()
    local wifi      = wibox.widget {
        font = beautiful.icon .. " 15",
        markup = helpers.colorizeText("", beautiful.fg_normal),
        widget = wibox.widget.textbox,
        valign = "center",
        align = "center"
      }
      
      awesome.connect_signal("signal::network", function(value)
        if value then
          wifi.markup = ""
        else
          wifi.markup = helpers.colorizeText("", beautiful.fg_dark .. "99")
        end
      end)
      
      return wifi
end

