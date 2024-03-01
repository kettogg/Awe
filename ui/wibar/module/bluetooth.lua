local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require('helpers')

return function()
	local bt = wibox.widget {
		font = beautiful.nerd .. ' 15',
		markup = helpers.recolorText('󰂯', beautiful.blue),
		widget = wibox.widget.textbox,
		valign = 'center',
		align = 'center',
	}

	awesome.connect_signal('signal::bluetooth', function(value)
		if value then
			bt.font = beautiful.nerd .. ' 15'
			bt.markup = helpers.recolorText('󰂯', beautiful.blue)
		else
			bt.font = beautiful.nerd .. ' 18' -- Idk why 󰂲 is smaller than 󰂯
			bt.markup = helpers.recolorText('󰂲', beautiful.fg_dark .. '99')
		end
	end)

	return bt
end
