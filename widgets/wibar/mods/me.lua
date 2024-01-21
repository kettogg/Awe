local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local awful = require("awful")

return function()
	local profile = wibox.widget {
		widget = wibox.widget.imagebox,
		image = beautiful.avatar,
		forced_height = 50,
		forced_width = 50,
		clip_shape = helpers.rrect(45),
		resize = true,
		buttons = {
		  awful.button({}, 1, function()
		    awesome.emit_signal('toggle::launcher')
		  end)
		},
	}
	return profile
end