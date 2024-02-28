local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local dpi       = beautiful.xresources.apply_dpi
-- Create a launcher widget. Opens the Awesome menu when clicked.
return function()
	local widget = wibox.widget({
		{
			{
				text = 'menu',
				font = beautiful.font,
				align = 'center',
				valign = 'center',
				widget = wibox.widget.textbox
			},
			margins = { left = dpi(30), right = dpi(14) },
			widget = wibox.container.margin,
		},
		fg      = beautiful.fg_normal,
		widget  = wibox.container.background,
		buttons = {
			awful.button(nil, 1, function()
				require('naughty').notification({
					title   = '<i>Oh, oh</i>',
					message = 'Dashboard is TODO!'
				})
			end)
		}
	})
	widget:connect_signal('mouse::enter', function(self)
		self.fg = beautiful.accent
	end)
	widget:connect_signal('mouse::leave', function(self)
		self.fg = beautiful.fg_normal
	end)
	return widget
end
