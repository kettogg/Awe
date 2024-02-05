local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
return function(s)
	local layoutbox = wibox.widget({
		{
			-- We need one layoutbox per screen.
			awful.widget.layoutbox({ screen = s }),
			margins = { left = dpi(12), right = dpi(12) },
			widget = wibox.container.margin,
		},
		fg      = beautiful.fg_normal,
		widget  = wibox.container.background,
		buttons = {
			awful.button(nil, 1, function() awful.layout.inc(1) end),
			awful.button(nil, 3, function() awful.layout.inc(-1) end),
			awful.button(nil, 4, function() awful.layout.inc(-1) end),
			awful.button(nil, 5, function() awful.layout.inc(1) end)
		}
	})
	layoutbox:connect_signal('mouse::enter', function(self)
		self.fg = beautiful.accent
	end)
	layoutbox:connect_signal('mouse::leave', function(self)
		self.fg = beautiful.fg_normal
	end)
	return layoutbox
end
