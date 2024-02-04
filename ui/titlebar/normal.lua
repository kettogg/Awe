local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
--- The titlebar to be used on normal clients.
return function(c)
	-- Buttons for the titlebar.
	local buttons = {
		awful.button(nil, 1, function()
			c:activate({ context = 'titlebar', action = 'mouse_move' })
		end),
		awful.button(nil, 3, function()
			c:activate({ context = 'titlebar', action = 'mouse_resize' })
		end)
	}

	local createButton = function(type)
		local button = wibox.widget {
			{
				{
					awful.titlebar.widget[type](c),
					layout = wibox.layout.fixed.horizontal,
				},
				widget = wibox.container.margin,
				margins = dpi(9),
			},
			bg = beautiful.bg_light,
			widget = wibox.container.background,
		}

		button:connect_signal('mouse::enter', function(self)
			self.bg = beautiful.mid_normal .. 'e6'
		end)
		button:connect_signal('mouse::leave', function(self)
			self.bg = beautiful.bg_light
		end)

		return button
	end
	-- Draws the client titlebar at the default position (top) and size.
	awful.titlebar(c, { size = dpi(36) }).widget = wibox.widget({
		widget = wibox.container.margin,
		bottom = dpi(1),
		color = beautiful.mid_normal,
		{
			layout = wibox.layout.align.horizontal,
			-- Left
			createButton('ontopbutton'),

			-- Middle
			{
				layout = wibox.layout.flex.horizontal,
				-- { -- Hide Title
				-- 	widget = awful.titlebar.widget.titlewidget(c),
				-- 	halign = 'center'
				-- },
				buttons = buttons
			},
			-- Right
			{
				layout = wibox.layout.fixed.horizontal,
				createButton('minimizebutton'),
				createButton('maximizedbutton'),
				createButton('closebutton')
			}
		},
	})
end
