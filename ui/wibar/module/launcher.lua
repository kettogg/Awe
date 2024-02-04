local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local dpi       = beautiful.xresources.apply_dpi
-- Create a launcher widget. Opens the Awesome menu when clicked.
return function()
	return wibox.widget {
		{
			markup = "<span foreground='" .. beautiful.fg_normal .. "'>menu</span>",
			-- font = beautiful.font,
			align = 'center',
			valign = 'center',
			widget = wibox.widget.textbox
		},
		margins = { left = dpi(30), right = dpi(14) },
		widget = wibox.container.margin,
		buttons = {},
	}
end
