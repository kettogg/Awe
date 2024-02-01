local awful  = require('awful')

local mod    = require('binds.mod')
local modkey = mod.modkey

--- Client keybindings.
client.connect_signal('request::default_keybindings', function()
	awful.keyboard.append_client_keybindings({
		-- Client state management.
		awful.key({ modkey, }, 'f',
			function(c)
				c.fullscreen = not c.fullscreen
				c:raise()
			end, { description = 'Toggle Fullscreen', group = 'client' }),
		awful.key({ modkey, }, 'q', function(c) c:kill() end,
			{ description = 'Close', group = 'client' }),
		awful.key({ modkey, }, 'space', awful.client.floating.toggle,
			{ description = 'Toggle Floating', group = 'client' }),
		awful.key({ modkey, }, 'n',
			function(c)
				-- The client currently has the input focus, so it cannot be
				-- minimized, since minimized clients can't have the focus.
				c.minimized = true
			end, { description = 'Minimize', group = 'client' }),
		awful.key({ modkey, }, 'm',
			function(c)
				c.maximized = not c.maximized
				c:raise()
			end, { description = '(Un)Maximize', group = 'client' }),
		awful.key({ modkey, mod.ctrl }, 'm',
			function(c)
				c.maximized_vertical = not c.maximized_vertical
				c:raise()
			end, { description = '(Un)Maximize Vertically', group = 'client' }),
		awful.key({ modkey, mod.shift }, 'm',
			function(c)
				c.maximized_horizontal = not c.maximized_horizontal
				c:raise()
			end, { description = '(Un)Maximize Horizontally', group = 'client' }),

		-- Client position in tiling management.
		awful.key({ modkey, mod.ctrl }, 'Return', function(c) c:swap(awful.client.getmaster()) end,
			{ description = 'Move To Master', group = 'client' }),
		awful.key({ modkey, }, 'o', function(c) c:move_to_screen() end,
			{ description = 'Move To Screen', group = 'client' }),
		awful.key({ modkey, }, 't', function(c) c.ontop = not c.ontop end,
			{ description = 'Toggle Keep On Top', group = 'client' })
	})
end)
