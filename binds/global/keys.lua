local awful         = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')

local mod           = require('binds.mod')
local modkey        = mod.modkey

local apps          = require('config.apps')
local widgets       = require('ui')
local brightness    = require('script.brightness')
local volume        = require('script.volume')

--- Global key bindings
awful.keyboard.append_global_keybindings({
	-- General Awesome keys.
	awful.key({ modkey, }, 's', function()
		local screen = awful.screen.focused()
		hotkeys_popup.widget.new({
			width = 1920,
			height = 1080,
		}):show_help(nil, screen)
	end, { description = 'Show Help', group = 'awesome' }),
	awful.key({ modkey, }, 'w', function() widgets.menu.main:show() end,
		{ description = 'Show Main Menu', group = 'awesome' }),
	awful.key({ modkey, mod.ctrl }, 'r', awesome.restart,
		{ description = 'Reload Awesome', group = 'awesome' }),
	awful.key({ modkey, mod.shift }, 'q', awesome.quit,
		{ description = 'Quit Awesome', group = 'awesome' }),
	awful.key({ modkey }, 'x', function()
		awful.prompt.run({
			prompt       = 'Run Lua Code: ',
			textbox      = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. '/history_eval'
		})
	end, { description = 'Lua Execute Prompt', group = 'awesome' }),
	awful.key({ modkey, }, 'Return', function() awful.spawn(apps.terminal) end,
		{ description = 'Open A Terminal', group = 'launcher' }),
	awful.key({ modkey }, 'r', function() awful.screen.focused().promptbox:run() end,
		{ description = 'Run Prompt', group = 'launcher' }),
	awful.key({ modkey }, 'p', function() require('menubar').show() end,
		{ description = 'Show The Menubar', group = 'launcher' }),

	-- Tags related keybindings.
	awful.key({ modkey, }, 'Left', awful.tag.viewprev,
		{ description = 'View Previous', group = 'tag' }),
	awful.key({ modkey, }, 'Right', awful.tag.viewnext,
		{ description = 'View Next', group = 'tag' }),
	awful.key({ modkey, }, 'Escape', awful.tag.history.restore,
		{ description = 'Go Back', group = 'tag' }),

	-- Focus related keybindings.
	awful.key({ modkey, }, 'j', function() awful.client.focus.byidx(-1) end,
		{ description = 'Focus Previous By Index', group = 'client' }),
	awful.key({ modkey, }, 'k', function() awful.client.focus.byidx(1) end,
		{ description = 'Focus Next By Index', group = 'client' }),
	awful.key({ modkey, }, 'Tab', function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = 'Go Back', group = 'client' }),
	awful.key({ modkey, mod.ctrl }, 'j', function() awful.screen.focus_relative(-1) end,
		{ description = 'Focus The Previous Screen', group = 'screen' }),
	awful.key({ modkey, mod.ctrl }, 'k', function() awful.screen.focus_relative(1) end,
		{ description = 'Focus The Next Screen', group = 'screen' }),
	awful.key({ modkey, mod.ctrl }, 'n', function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:activate { raise = true, context = 'key.unminimize' }
		end
	end, { description = 'Restore Minimized', group = 'client' }),

	-- Layout related keybindings.
	awful.key({ modkey, mod.shift }, 'j', function() awful.client.swap.byidx(-1) end,
		{ description = 'Swap With Previous Client By Index', group = 'client' }),
	awful.key({ modkey, mod.shift }, 'k', function() awful.client.swap.byidx(1) end,
		{ description = 'Swap With Next Client By Index', group = 'client' }),
	awful.key({ modkey, }, 'u', awful.client.urgent.jumpto,
		{ description = 'Jump To Urgent Client', group = 'client' }),
	awful.key({ modkey, }, 'l', function() awful.tag.incmwfact(0.05) end,
		{ description = 'Increase Master Width Factor', group = 'layout' }),
	awful.key({ modkey, }, 'h', function() awful.tag.incmwfact(-0.05) end,
		{ description = 'Decrease Master Width Factor', group = 'layout' }),
	awful.key({ modkey, mod.shift }, 'h', function() awful.tag.incnmaster(-1, nil, true) end,
		{ description = 'Decrease The Number Of Master Clients', group = 'layout' }),
	awful.key({ modkey, mod.shift }, 'l', function() awful.tag.incnmaster(1, nil, true) end,
		{ description = 'Increase The Number Of Master Clients', group = 'layout' }),
	awful.key({ modkey, mod.ctrl }, 'h', function() awful.tag.incncol(-1, nil, true) end,
		{ description = 'Deccrease The Number Of Columns', group = 'layout' }),
	awful.key({ modkey, mod.ctrl }, 'l', function() awful.tag.incncol(1, nil, true) end,
		{ description = 'Increase The Number Of Columns', group = 'layout' }),
	awful.key({ modkey, }, 'space', function() awful.layout.inc(1) end,
		{ description = 'Select Next', group = 'layout' }),
	awful.key({ modkey, mod.shift }, 'space', function() awful.layout.inc(-1) end,
		{ description = 'Select Previous', group = 'layout' }),
	awful.key({
		modifiers   = { modkey },
		keygroup    = 'numrow',
		description = 'Only View Tag',
		group       = 'tag',
		on_press    = function(index)
			local tag = awful.screen.focused().tags[index]
			if tag then tag:view_only() end
		end
	}),
	awful.key({
		modifiers   = { modkey, mod.ctrl },
		keygroup    = 'numrow',
		description = 'Toggle Tag',
		group       = 'tag',
		on_press    = function(index)
			local tag = awful.screen.focused().tags[index]
			if tag then awful.tag.viewtoggle(tag) end
		end
	}),
	awful.key({
		modifiers   = { modkey, mod.shift },
		keygroup    = 'numrow',
		description = 'Move Focused Client To Tag',
		group       = 'tag',
		on_press    = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then client.focus:move_to_tag(tag) end
			end
		end
	}),
	awful.key({
		modifiers   = { modkey, mod.ctrl, mod.shift },
		keygroup    = 'numrow',
		description = 'Toggle Focused Client On Tag',
		group       = 'tag',
		on_press    = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then client.focus:toggle_tag(tag) end
			end
		end
	}),
	awful.key({
		modifiers   = { modkey },
		keygroup    = 'numpad',
		description = 'Select Layout Directly',
		group       = 'layout',
		on_press    = function(index)
			local t = awful.screen.focused().selected_tag
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end
	}),

	-- Volume
	awful.key({}, 'XF86AudioRaiseVolume', function()
		volume.increase()
	end),
	awful.key({}, 'XF86AudioLowerVolume', function()
		volume.decrease()
	end),
	awful.key({}, 'XF86AudioMute', function()
		volume.mute()
	end),

	-- Brightness
	awful.key({}, 'XF86MonBrightnessUp', function()
		brightness.increase()
	end),

	awful.key({}, 'XF86MonBrightnessDown', function()
		brightness.decrease()
	end),

	-- Screenshot -- TODO: Fix this
	awful.key({
		modifiers   = { modkey },
		key         = 'Print',
		description = 'Takes a full screenshot',
		group       = 'miscelaneous',
		on_press    = function()
			awful.spawn('maim ~/Pictures/Screenshots/$(date +%s).png')
		end
	}),
	awful.key({
		modifiers   = { modkey, mod.shift },
		key         = 'Print',
		description = 'Takes a selection screenshot',
		group       = 'miscelaneous',
		on_press    = function()
			awful.spawn('maim -s ~/Pictures/Screenshots/$(date +%s).png')
		end
	}),
})
