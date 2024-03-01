local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local helpers   = require('helpers')
local dpi       = beautiful.xresources.apply_dpi
local wifi      = require('ui.wibar.module.wifi')
local bt        = require('ui.wibar.module.bluetooth')
local bat       = require('ui.wibar.module.battery')
-- Create a launcher widget. Opens the Awesome menu when clicked.
return function()
	local control = wibox.widget {
		{
			{
				bat(),
				wifi(),
				bt(),
				spacing = dpi(6),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = { top = dpi(6), bottom = dpi(6), left = dpi(8), right = dpi(8) },
			widget = wibox.container.margin,
		},
		shape = helpers.rrect(1),
		bg = beautiful.bg_light,
		widget = wibox.container.background,
	}

	local widget = wibox.widget {
		control,
		widget = wibox.container.margin,
	}

	return widget
end
