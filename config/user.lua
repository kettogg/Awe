local awful = require('awful')

-- Specify user preferences for Awesome's behavior.
return {
	-- Default modkey.
	-- Usually, Mod4 is the key with a logo between Control and Alt. If you do not like
	-- this or do not have such a key, I suggest you to remap Mod4 to another key using
	-- xmodmap or other tools. However, you can use another modifier like Mod1, but it
	-- may interact with others.
	mod           = 'Mod4',
	-- Each screen has its own tag table. You can just define one and append it to all
	-- screens (default behavior).
	tags          = { '1', '2', '3', '4', '5', },

	-- Table of layouts to cover with awful.layout.inc, ORDER MATTERS, the first layout
	-- in the table is your DEFAULT LAYOUT.
	layouts       = {
		awful.layout.suit.floating,
		awful.layout.suit.tile,
		--awful.layout.suit.tile.left,
		--awful.layout.suit.tile.bottom,
		--awful.layout.suit.tile.top,
		--awful.layout.suit.fair,
		--awful.layout.suit.fair.horizontal,
		--awful.layout.suit.spiral,
		--awful.layout.suit.spiral.dwindle,
		--awful.layout.suit.max,
		--awful.layout.suit.max.fullscreen,
		--awful.layout.suit.magnifier,
		--awful.layout.suit.corner.nw
	},
	screen_width  = 1920,
	screen_height = 1080,
	colorscheme   = 'oxocarbon',
	avatar        = nil,                                        -- Full path to your pfp
	wallpaper     = nil,
	icons         = '/home/ketto/.icons/Zafiro-Icons-Dark-Blue', -- Can't be nil as not handled in theme/init.lua
	shooter_dir   = '~/Pictures/Screenshots/'                   -- Screenshot directory
}
