local awful = require('awful')
local wibox = require('wibox')
local dpi   = require('beautiful.xresources').apply_dpi
return function(s)
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	local layoutbox = awful.widget.layoutbox({
		screen  = s,
		buttons = {
			awful.button(nil, 1, function() awful.layout.inc(1) end),
			awful.button(nil, 3, function() awful.layout.inc(-1) end),
			awful.button(nil, 4, function() awful.layout.inc(-1) end),
			awful.button(nil, 5, function() awful.layout.inc(1) end)
		}
	})

	return wibox.widget {
		layoutbox,
		margins = { left = dpi(12), right = dpi(12) },
		widget = wibox.container.margin,
	}
end
