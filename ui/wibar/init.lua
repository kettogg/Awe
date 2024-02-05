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
		bg = beautiful.bg_normal,
		height   = dpi(44),
		-- ontop    = true,
		widget   = {
			widget = wibox.container.margin,
			top = dpi(1),
			color = beautiful.mid_normal,
			{
				layout = wibox.layout.align.horizontal,
				-- Left widgets.
				{
					layout = wibox.layout.fixed.horizontal,
					module.launcher(),
					module.taglist(s),
					module.layoutbox(s),
					{
						s.promptbox,
						margins = { left = dpi(4), right = dpi(4) },
						widget = wibox.container.margin
					},
				},
				-- Middle widgets.
				module.tasklist(s),
				-- Right widgets.
				{
					layout = wibox.layout.fixed.horizontal,
					module.systray(),
					awful.widget.keyboardlayout(), -- Keyboard map indicator and switcher.
					{
						wibox.widget.textclock("%H:%M <span foreground='" ..
							beautiful.mid_light .. "'>/</span> <span font='" .. beautiful.font .. " Italic'>%B %d</span>"), -- Create a textclock widget.
						margins = { left = dpi(12), right = dpi(30) },
						widget  = wibox.container.margin,
					},
				}
			}
		}
	})
end
