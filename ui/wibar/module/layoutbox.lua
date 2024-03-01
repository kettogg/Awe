local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local helpers   = require('helpers')
local dpi       = beautiful.xresources.apply_dpi
return function(s)
	local layoutbox = wibox.widget {
		-- We need one layoutbox per screen.
		{
			awful.widget.layoutbox({ screen = s }),
			margins = dpi(10),
			widget = wibox.container.margin,
		},
		fg      = beautiful.fg_normal,
		bg      = beautiful.bg_light,
		shape   = helpers.rrect(1),
		widget  = wibox.container.background,
		buttons = {
			awful.button(nil, 1, function() awful.layout.inc(1) end),
			awful.button(nil, 3, function() awful.layout.inc(-1) end),
			awful.button(nil, 4, function() awful.layout.inc(-1) end),
			awful.button(nil, 5, function() awful.layout.inc(1) end)
		}
	}

	local widget = wibox.widget {
		layoutbox,
		widget = wibox.container.margin
	}

	return widget
end
