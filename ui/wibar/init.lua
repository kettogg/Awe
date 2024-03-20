local awful     = require('awful')
local wibox     = require('wibox')

local module    = require(... .. '.module')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

return function(s)
	s.promptbox = awful.widget.prompt({
		prompt = 'Run: ',
		fg_cursor = beautiful.bg_normal,
		bg_cursor = beautiful.fg_normal,
	}) -- Create a promptbox.

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = 'bottom',
		screen   = s,
		bg       = beautiful.bg_normal,
		height   = dpi(46),
		-- ontop    = true,
		widget   = {
			{
				-- Left widgets.
				{
					{
						module.launcher(),
						module.taglist(s),
						{
							s.promptbox,
							margins = { left = dpi(2), right = dpi(2) },
							widget = wibox.container.margin
						},
						layout = wibox.layout.fixed.horizontal,
					},
					widget = wibox.container.place,
					valign = 'center',
				},

				-- Middle widgets.
				module.tasklist(s),

				-- Right widgets.
				{
					{
						module.systray(),
						module.music(),
						-- module.control(),
						module.time(),
						module.layoutbox(s),
						spacing = dpi(5),
						layout = wibox.layout.fixed.horizontal,
					},
					margins = { top = dpi(5), bottom = dpi(5), left = dpi(6), right = dpi(6) },
					widget = wibox.container.margin
				},
				layout = wibox.layout.align.horizontal,
			},
			top = dpi(1),
			color = beautiful.mid_normal,
			widget = wibox.container.margin,
		}
	})
end
