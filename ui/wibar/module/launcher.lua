local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local helpers   = require('helpers')
local dpi       = beautiful.xresources.apply_dpi
-- Create a launcher widget. Opens the Awesome menu when clicked.
return function()
	local launcher = wibox.widget {
		{
			widget = wibox.widget.imagebox,
			image = beautiful.avatar,
			forced_height = dpi(34),
			forced_width = dpi(34),
			clip_shape = helpers.rrect(34),
			resize = true,
		},
		margins = { left = dpi(10), right = dpi(6) },
		widget = wibox.container.margin,

		buttons = {
			awful.button({}, 1, function()
				awesome.emit_signal('toggle::launcher')
			end)
		},
	}

	return launcher
end
