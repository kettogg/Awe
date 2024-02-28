local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
return function(s)
	-- Create a tasklist widget
	local tasklist = awful.widget.tasklist({
		screen          = s,
		filter          = awful.widget.tasklist.filter.currenttags,
		layout          = {
			layout = wibox.layout.flex.horizontal,
		},
		style           = {
			-- Colors.
			fg_minimize  = beautiful.mid_normal,
			fg_normal    = beautiful.mid_normal,
			fg_focus     = beautiful.fg_normal,
			fg_urgent    = beautiful.red,
			bg_focus     = beautiful.bg_normal,
			bg_urgent    = beautiful.bg_normal,
			bg_minimize  = beautiful.bg_normal,
			-- Styling.
			font         = beautiful.font,
			disable_icon = true,
			maximized    = '[+]',
			minimized    = '[-]',
			sticky       = '[*]',
			floating     = '[~]',
			ontop        = '[^]',
			above        = '[^]'
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
