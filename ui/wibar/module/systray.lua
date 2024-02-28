local awful     = require('awful')
local beautiful = require('beautiful')
local helpers   = require('helpers')
local wibox     = require('wibox')
local dpi       = require('beautiful').xresources.apply_dpi

return function()
	-- Toggler
	local togglertext = wibox.widget({
		{
			id = 'toggle-icon',
			font = beautiful.nerd,
			text = '',
			valign = 'center',
			align = 'center',
			widget = wibox.widget.textbox,
		},
		fg     = beautiful.fg_normal,
		widget = wibox.container.background,
	})
	togglertext:connect_signal('mouse::enter', function(self)
		self.fg = beautiful.accent
	end)
	togglertext:connect_signal('mouse::leave', function(self)
		self.fg = beautiful.fg_normal
	end)

	-- Tray
	local systray = wibox.widget({
		{
			{
				widget = wibox.widget.systray,
			},
			widget = wibox.container.place,
			valign = 'center',
		},
		visible = false,
		left = 4,
		right = 4,
		widget = wibox.container.margin
	})
	local icon = togglertext:get_children_by_id('toggle-icon')[1]
	awesome.connect_signal('systray::toggle', function()
		if systray.visible then
			systray.visible = false
			icon.text = ''
		else
			systray.visible = true
			icon.text = ''
		end
	end)

	local widget = wibox.widget({
		{
			systray,
			togglertext,
			layout = wibox.layout.fixed.horizontal,
		},
		buttons = {
			awful.button({}, 1, function()
				awesome.emit_signal('systray::toggle')
			end)
		},
		margins = { left = dpi(12), right = dpi(12) },
		widget  = wibox.container.margin,
	})

	return widget
end
