local awful     = require('awful')
local wibox     = require('wibox')

local module    = require(... .. '.module')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

return function(s)
	s.mypromptbox = awful.widget.prompt() -- Create a promptbox.

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = 'bottom',
		screen   = s,
		height   = dpi(40),
		ontop    = true,
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
					s.mypromptbox
				},
				-- Middle widgets.
				module.tasklist(s),
				-- Right widgets.
				{
					layout = wibox.layout.fixed.horizontal,
					awful.widget.keyboardlayout(), -- Keyboard map indicator and switcher.
					wibox.widget.systray(),
					wibox.widget.textclock(), -- Create a textclock widget.
					module.layoutbox(s)
				}
			}
		}
	})
end
