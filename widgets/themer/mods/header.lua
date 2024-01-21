local awful      = require("awful")
local wibox      = require("wibox")
local gears      = require("gears")
local beautiful  = require("beautiful")
local colors     = require('widgets.themer.mods.colors')
local dpi        = beautiful.xresources.apply_dpi
local gfs        = gears.filesystem
local asset_path = gfs.get_configuration_dir() .. 'theme/assets/tools/'
local capturer   = require('widgets.capturer.init')


local profile_image = wibox.widget {
	{
		image      = beautiful.avatar,
		clip_shape = gears.shape.circle,
		widget     = wibox.widget.imagebox
	},
	forced_width  = dpi(40),
	forced_height = dpi(40),
	widget        = wibox.container.background
}

local username = wibox.widget {
	markup = '',
	font   = beautiful.font_sans .. ' 13',
	align  = 'left',
	widget = wibox.widget.textbox
}

awful.spawn.easy_async_with_shell(
	'whoami', function(stdout)
		local name      = stdout:match('(%w+)')
		username.markup = "<span foreground='" .. colors.fg_light .. 'E6' .. "'>Heya, </span><span foreground='" ..
				colors.blue .. 'F2' ..
				"'>" ..
				-- name .. -- Uncomment this for username
				"Aniketto" ..
				"</span><span foreground='" .. colors.fg_light .. 'E6' .. "' size='large'> (˶ᵔ ᵕ ᵔ˶)</span>"
	end
)

return wibox.widget {
	{
		{
			{
				profile_image,

				{
					{

						{
							username,
							layout = wibox.layout.fixed.horizontal
						},
						widget  = wibox.container.margin,
						margins = { bottom = dpi(4) }
					},
					widget = wibox.container.place
				},
				spacing = dpi(12),
				layout = wibox.layout.fixed.horizontal,

			},
			nil,
			layout = wibox.layout.align.horizontal
		},
		widget = wibox.container.margin,
	},
	widget = wibox.container.margin,
	margins = { left = 4 },
}
