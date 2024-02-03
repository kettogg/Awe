local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local dpi       = beautiful.xresources.apply_dpi
-- Create a launcher widget. Opens the Awesome menu when clicked.
return function()
	return wibox.widget {
		{
			markup = "<span foreground='" .. beautiful.fg_normal .. "'>Menu</span>",
			font = beautiful.term,
			align = 'center',
			valign = 'center',
			widget = wibox.widget.textbox
		},
		margins = { left = dpi(20), right = dpi(20), top = dpi(4), bottom = dpi(4) },
		widget = wibox.container.margin,
	}
end
