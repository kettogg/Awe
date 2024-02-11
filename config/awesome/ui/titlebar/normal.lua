local awful        = require('awful')
local wibox        = require('wibox')
local beautiful    = require('beautiful')
local dpi          = beautiful.xresources.apply_dpi
local gears        = require('gears')
local recolorImage = require('helpers').recolorImage
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

	-- Left button (Using it for Ontop)
	local command = wibox.widget {
		{
			{
				image           = recolorImage(beautiful.command_butt, beautiful.fg_normal),
				resize          = true,
				scaling_quality = 'nearest',
				widget          = wibox.widget.imagebox
			},
			margins = dpi(10),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_light,
		widget = wibox.container.background,
	}
	command.isActive = false
	local switchBg = function()
		if command.isActive then
			command.bg = beautiful.mid_normal .. 'e6'
		else
			command.bg = beautiful.bg_light
		end
	end
	command:buttons({ awful.button({}, 1, function()
		c.ontop = not c.ontop
		command.isActive = c.ontop
		switchBg()
	end) })
	command:connect_signal('mouse::enter', function(self)
		if (self.isActive) then
			self.bg = beautiful.mid_normal .. 'e6'
		else
			self.bg = beautiful.mid_normal .. 'e6'
		end
	end)
	command:connect_signal('mouse::leave', function(self)
		if (self.isActive) then
			self.bg = beautiful.mid_normal .. 'e6'
		else
			self.bg = beautiful.bg_light
		end
	end)

	-- Right buttons (Min, Max, Close)
	local hoverEffect = function(widget, id, enter)
		if enter then
			widget:get_children_by_id(id)[1].left = dpi(10)
			widget:get_children_by_id(id)[1].right = dpi(10)
		else
			widget:get_children_by_id(id)[1].left = dpi(4)
			widget:get_children_by_id(id)[1].right = (id == 'close') and dpi(10) or dpi(4)
		end
	end

	local minimize = wibox.widget {
		{
			{
				image           = recolorImage(beautiful.minimize_butt, beautiful.fg_normal),
				resize          = true,
				scaling_quality = 'nearest',
				widget          = wibox.widget.imagebox
			},
			id = 'min',
			left = dpi(4),
			right = dpi(4),
			top = dpi(10),
			bottom = dpi(10),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_light,
		widget = wibox.container.background,
	}
	minimize:connect_signal('mouse::enter', function(self)
		hoverEffect(minimize, 'min', true)
		self.bg = beautiful.mid_normal .. 'e6'
	end)
	minimize:connect_signal('mouse::leave', function(self)
		hoverEffect(minimize, 'min', false)
		self.bg = beautiful.bg_light
	end)
	minimize:buttons({ awful.button({}, 1, function()
		gears.timer.delayed_call(function()
			c.minimized = not c.minimized
		end)
	end) })

	local maximize = wibox.widget {
		{
			{
				id              = 'maxIcon',
				image           = recolorImage(beautiful.expand_butt, beautiful.fg_normal),
				resize          = true,
				scaling_quality = 'nearest',
				widget          = wibox.widget.imagebox
			},
			id = 'max',
			left = dpi(4),
			right = dpi(4),
			top = dpi(10),
			bottom = dpi(10),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_light,
		widget = wibox.container.background,
	}
	maximize:connect_signal('mouse::enter', function(self)
		hoverEffect(maximize, 'max', true)
		self.bg = beautiful.mid_normal .. 'e6'
	end)
	maximize:connect_signal('mouse::leave', function(self)
		hoverEffect(maximize, 'max', false)
		self.bg = beautiful.bg_light
	end)

	local changeIcon = function(isMaximized)
		if isMaximized then
			maximize:get_children_by_id('maxIcon')[1].image = recolorImage(beautiful.unexpand_butt, beautiful.fg_normal)
		else
			maximize:get_children_by_id('maxIcon')[1].image = recolorImage(beautiful.expand_butt, beautiful.fg_normal)
		end
	end
	maximize:buttons({ awful.button({}, 1, function()
		c.maximized = not c.maximized
		gears.timer.delayed_call(function()
			-- The bg from hoverEffect persists need to fix that!
			changeIcon(c.maximized)
		end)
	end) })

	local close = wibox.widget {
		{
			{
				image           = recolorImage(beautiful.close_butt, beautiful.fg_normal),
				resize          = true,
				scaling_quality = 'nearest',
				widget          = wibox.widget.imagebox
			},
			id = 'close',
			left = dpi(4),
			right = dpi(10),
			top = dpi(10),
			bottom = dpi(10),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_light,
		widget = wibox.container.background,
	}
	close:connect_signal('mouse::enter', function(self)
		hoverEffect(close, 'close', true)
		self.bg = beautiful.red_dark .. 'e6'
	end)
	close:connect_signal('mouse::leave', function(self)
		hoverEffect(close, 'close', false)
		self.bg = beautiful.bg_light
	end)
	close:buttons({ awful.button({}, 1, function()
		c:kill()
	end) })

	-- Draws the client titlebar at the default position (top) and size.
	awful.titlebar(c, { size = dpi(40) }).widget = wibox.widget({
		widget = wibox.container.margin,
		bottom = dpi(1),
		color = beautiful.mid_normal,
		{
			layout = wibox.layout.align.horizontal,
			-- Left
			command,
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
				minimize,
				maximize,
				close,
			}
		},
	})
end
