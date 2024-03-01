local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require('helpers')

return function(s)
	local tasklist = awful.widget.tasklist({
		screen          = s,
		filter          = awful.widget.tasklist.filter.currenttags,
		source          = function()
			local ret = {}
			for _, t in ipairs(s.tags) do
				gears.table.merge(ret, t:clients())
			end
			return ret
		end,
		style           = {
			disable_task_name = true,
			bg_normal         = beautiful.transparent,
			bg_focus          = beautiful.bg_light,
			bg_urgent         = beautiful.red_dark,
			bg_minimize       = beautiful.transparent,
			shape             = helpers.rrect(1),
		},
		layout          = {
			spacing = dpi(4),
			layout = wibox.layout.fixed.horizontal
		},
		widget_template = {
			widget = wibox.container.background,
			id     = 'background_role',
			{
				widget  = wibox.container.margin,
				margins = dpi(5),
				{
					widget = awful.widget.clienticon
				}
			}
		},
		buttons         = {
			-- Left-clicking a client indicator minimizes it if it's unminimized, or unminimizes
			-- it if it's minimized.
			awful.button(nil, 1, function(c)
				c:activate({ context = 'tasklist', action = 'toggle_minimization' })
			end),
			-- Mousewheel scrolling cycles through clients.
			awful.button(nil, 4, function() awful.client.focus.byidx(1) end),
			awful.button(nil, 5, function() awful.client.focus.byidx(-1) end)
		}
	})

	local widget = wibox.widget({
		tasklist,
		margins = { top = dpi(5), bottom = dpi(5), left = dpi(4), right = dpi(4) },
		widget = wibox.container.margin,
	})

	return widget
end
