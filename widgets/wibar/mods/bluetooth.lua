local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local helpers   = require("helpers")

return function()
    local blue      = wibox.widget {
        font = beautiful.icon .. " 15",
        markup = helpers.colorizeText("󰂯", beautiful.fg_normal),
        widget = wibox.widget.textbox,
        valign = "center",
        align = "center"
      }
      
      awesome.connect_signal("signal::bluetooth", function(value)
        if value then
          blue.markup = helpers.colorizeText("󰂯", beautiful.blue)
        else
          blue.markup = helpers.colorizeText("󰂲", beautiful.fg_dark .. "99")
        end
      end)
      
      return blue
end


