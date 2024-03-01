local awful     = require('awful')
local wibox     = require('wibox')
local helpers   = require('helpers')
local animation = require('module.animation')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local modkey    = require('binds.mod').modkey

return function(s)
	-- Create a taglist widget
	local taglist = awful.widget.taglist {
		screen          = s,
		filter          = awful.widget.taglist.filter.all,
		layout          = {
			spacing = 8,
			layout = wibox.layout.fixed.horizontal,
		},
		style           = {
			shape = helpers.slantrect(1)
		},
		widget_template = {
			{
				valign        = 'center',
				id            = 'background_role',
				shape         = helpers.rrect(0),
				widget        = wibox.container.background,
				forced_width  = 60,
				forced_height = dpi(1),
			},
			widget = wibox.container.place,
			create_callback = function(self, tag)
				self.taganim = animation:new({
					duration = 0.25,
					easing = animation.easing.linear,
					update = function(_, pos)
						self:get_children_by_id('background_role')[1].forced_width = pos
					end,
				})
				self.update = function()
					if tag.selected then
						self.taganim:set(90)
					elseif #tag:clients() > 0 then
						self.taganim:set(64)
					else
						self.taganim:set(40)
					end
				end

				self.update()
			end,
			update_callback = function(self)
				self.update()
			end,
		},

		buttons         = {
			-- Left-clicking a tag changes to it.
			awful.button(nil, 1, function(t) t:view_only() end),
			-- Mod + Left-clicking a tag sends the currently focused client to it.
			awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			-- Right-clicking a tag makes its contents visible in the current one.
			awful.button(nil, 3, awful.tag.viewtoggle),
			-- Mod + Right-clicking a tag makes the currently focused client visible
			-- in it.
			awful.button({ modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			-- Mousewheel scrolling cycles through tags.
			awful.button(nil, 4, function(t) awful.tag.viewnext(t.screen) end),
			awful.button(nil, 5, function(t) awful.tag.viewprev(t.screen) end)
		}
	}

	local widget = wibox.widget {
		{
			{
				taglist,
				margins = { left = dpi(14), right = dpi(14) },
				widget = wibox.container.margin,
			},
			shape = helpers.rrect(1),
			bg = beautiful.bg_light,
			widget = wibox.container.background,
		},
		margins = { top = dpi(1), bottom = dpi(1), left = dpi(4), right = dpi(4) },
		widget = wibox.container.margin,
	}

	return widget
end
