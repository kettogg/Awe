local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = require('beautiful').xresources.apply_dpi
local helpers   = require('helpers')

return function()
	local time = wibox.widget {
		{
			{
				font = beautiful.font .. ' 13',
				format = '%H:%M',
				align = 'center',
				valign = 'center',
				widget = wibox.widget.textclock
			},
			margins = { left = dpi(9), right = dpi(9) },
			widget = wibox.container.margin
		},
		shape = helpers.rrect(1),
		fg = beautiful.fg_normal,
		bg = beautiful.bg_light,
		widget = wibox.container.background,
	}

	time:connect_signal('mouse::enter', function(self)
		self.fg = beautiful.accent
	end)
	time:connect_signal('mouse::leave', function(self)
		self.fg = beautiful.fg_normal
	end)

	local widget = wibox.widget {
		time,
		widget = wibox.container.margin
	}

	return widget
end
