local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require('helpers')

return function()
	local wifi = wibox.widget {
		font = beautiful.nerd .. ' 26',
		markup = '󰤨',
		widget = wibox.widget.textbox,
		valign = 'center',
		align = 'center'
	}

	awesome.connect_signal('signal::network', function(value)
		if value then
			wifi.markup = '󰤨'
		else
			wifi.markup = helpers.recolorText('󰤭', beautiful.fg_dark .. '99')
		end
	end)

	return wifi
end
