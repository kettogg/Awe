local awful = require('awful')
local wibox = require('wibox')
local dpi = require('beautiful.xresources').apply_dpi
return function(s)
	-- Create a tasklist widget
	local tasklist = awful.widget.tasklist({
		screen          = s,
		filter          = awful.widget.tasklist.filter.currenttags,
		layout          = {
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				{
					{
						id            = 'text_role',
						forced_height = dpi(24),
						widget        = wibox.widget.textbox,
					},
					halign = 'center',
					valign = 'center',
					layout = wibox.container.place,
				},
				left   = 10,
				right  = 10,
				widget = wibox.container.margin
			},
			id     = 'background_role',
			widget = wibox.container.background,
		},
		buttons         = {
			-- Left-clicking a client indicator minimizes it if it's unminimized, or unminimizes
			-- it if it's minimized.
			awful.button(nil, 1, function(c)
				c:activate({ context = 'tasklist', action = 'toggle_minimization' })
			end),
			-- Right-clicking a client indicator shows the list of all open clients in all visible
			-- tags.
			awful.button(nil, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
			-- Mousewheel scrolling cycles through clients.
			awful.button(nil, 4, function() awful.client.focus.byidx(1) end),
			awful.button(nil, 5, function() awful.client.focus.byidx(-1) end)
		}
	})

	return {
		tasklist,
		margins = { left = dpi(12), right = dpi(12) },
		widget = wibox.container.margin,
	}
end
