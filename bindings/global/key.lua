local awful         = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')
local apps       = require('config.apps')
local mod        = require('bindings.mod')
local screenshot = require('script.screenshot')
local gears      = require('gears')
local gfs        = gears.filesystem
local config_dir = gfs.get_configuration_dir()

local volume     = require("lib.volume")
local brightness = require("lib.brightness")

-- General awesome keys
awful.keyboard.append_global_keybindings {
  awful.key {
    modifiers   = { mod.super },
    key         = 's',
    description = 'Show Help',
    group       = 'awesome',
    on_press    = hotkeys_popup.show_help
  },
  awful.key {
    modifiers   = { mod.super },
    key         = 'w',
    description = 'Show Laucher',
    group       = 'awesome',
    on_press    = function() awesome.emit_signal('toggle::launcher') end
  },
  awful.key {
    modifiers   = { mod.super, mod.ctrl },
    key         = 'r',
    description = 'Reload Awesome',
    group       = 'awesome',
    on_press    = awesome.restart
  },
  -- awful.key {
  --    modifiers   = { mod.super, mod.shift },
  --    key         = 'q',
  --    description = 'Quit Awesome',
  --    group       = 'awesome',
  --    on_press    = awesome.quit
  -- },
  awful.key {
    modifiers   = { mod.super },
    key         = 'Return',
    description = 'Open Terminal',
    group       = 'launcher',
    on_press    = function() awful.spawn(apps.terminal) end
  },
  awful.key {
    modifiers   = { mod.super, mod.ctrl },
    key         = 'Return',
    description = 'Open Terminal(Floating)',
    group       = 'launcher',
    on_press    = function() awful.spawn(apps.terminal, { floating = true }) end
  },

  -- Widgets
  awful.key {
    modifiers   = { mod.super },
    key         = 't',
    description = 'Show Screenshot Tool',
    group       = 'launcher',
    on_press    = function() awesome.emit_signal("toggle::scrotter") end
  }
}

-- Tags related keybindings
awful.keyboard.append_global_keybindings {
  awful.key {
    modifiers   = { mod.super },
    key         = 'Left',
    description = 'View Previous',
    group       = 'tag',
    on_press    = awful.tag.viewprev
  },
  awful.key {
    modifiers   = { mod.super },
    key         = 'Right',
    description = 'View Next',
    group       = 'tag',
    on_press    = awful.tag.viewnext
  },
  awful.key {
    modifiers   = { mod.super },
    key         = 'Escape',
    description = 'Go Back',
    group       = 'tag',
    on_press    = awful.tag.history.restore
  }
}

-- Focus related keybindings
awful.keyboard.append_global_keybindings {
  awful.key {
    modifiers   = { mod.super },
    key         = 'j',
    description = 'Focus next by index',
    group       = 'client',
    on_press    = function() awful.client.focus.byidx(1) end
  },
  awful.key {
    modifiers   = { mod.super },
    key         = 'k',
    description = 'Focus previous by index',
    group       = 'client',
    on_press    = function() awful.client.focus.byidx(-1) end
  },
  awful.key {
    modifiers   = { mod.super },
    key         = 'Tab',
    description = 'Go back',
    group       = 'client',
    on_press    = function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end
  },
  awful.key {
    modifiers   = { mod.super, mod.ctrl },
    key         = 'j',
    description = 'Focus the next screen',
    group       = 'screen',
    on_press    = function() awful.screen.focus_relative(1) end
  },
  awful.key {
    modifiers   = { mod.super, mod.ctrl },
    key         = 'n',
    description = 'Restore minimized',
    group       = 'client',
    on_press    = function()
      local c = awful.client.restore()
      if c then
        c:active { raise = true, context = 'key.unminimize' }
      end
    end
  }
}

-- Layout related keybindings
awful.keyboard.append_global_keybindings {
  awful.key {
    modifiers   = { mod.super, mod.shift },
    key         = 'j',
    description = 'Swap with next client by index',
    group       = 'client',
    on_press    = function() awful.client.swap.byidx(1) end
  },
  awful.key {
    modifiers   = { mod.super, mod.shift },
    key         = 'k',
    description = 'Swap with previous client by index',
    group       = 'client',
    on_press    = function() awful.client.swap.byidx(-1) end
  },
  awful.key {
    modifiers   = { mod.super },
    key         = 'u',
    description = 'Jump to urgent client',
    group       = 'client',
    on_press    = awful.client.urgent.jumpto
  },
  awful.key {
    modifiers   = { mod.super },
    key         = 'l',
    description = 'Increase master width factor',
    group       = 'layout',
    on_press    = function() awful.tag.incmwfact(0.05) end
  },
  awful.key {
    modifiers   = { mod.super },
    key         = 'h',
    description = 'Decrease master width factor',
    group       = 'layout',
    on_press    = function() awful.tag.incmwfact(-0.05) end
  },
  awful.key {
    modifiers   = { mod.super, mod.shift },
    key         = 'h',
    description = 'Increase the number of master clients',
    group       = 'layout',
    on_press    = function() awful.tag.incnmaster(1, nil, true) end
  },
  awful.key {
    modifiers   = { mod.super, mod.shift },
    key         = 'l',
    description = 'Decrease the number of master clients',
    group       = 'layout',
    on_press    = function() awful.tag.incnmaster(-1, nil, true) end
  },
  awful.key {
    modifiers   = { mod.super, mod.alt },
    key         = 'k',
    description = 'Increase client width factor',
    group       = 'layout',
    on_press    = function() awful.client.incwfact(0.05) end
  },
  awful.key {
    modifiers   = { mod.super, mod.alt },
    key         = 'j',
    description = 'Decrease client width factor',
    group       = 'layout',
    on_press    = function() awful.client.incwfact(-0.05) end
  },
  awful.key {
    modifiers   = { mod.super, mod.ctrl },
    key         = 'h',
    description = 'Increase the number of columns',
    group       = 'layout',
    on_press    = function() awful.tag.incnmaster(1, nil, true) end
  },
  awful.key {
    modifiers   = { mod.super, mod.ctrl },
    key         = 'l',
    description = 'Decrease the number of columns',
    group       = 'layout',
    on_press    = function() awful.tag.incnmaster(-1, nil, true) end
  },
  awful.key {
    modifiers   = { mod.super },
    key         = 'space',
    description = 'Select Next',
    group       = 'layout',
    on_press    = function() awful.layout.inc(1) end
  },
  awful.key {
    modifiers   = { mod.super, mod.shift },
    key         = 'space',
    description = 'Select Previous',
    group       = 'layout',
    on_press    = function() awful.layout.inc(-1) end
  }
}

awful.keyboard.append_global_keybindings {
  awful.key {
    modifiers   = { mod.super },
    keygroup    = 'numrow',
    description = 'Only view tag',
    group       = 'tag',
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only(tag)
      end
    end
  },
  awful.key {
    modifiers   = { mod.super, mod.ctrl },
    keygroup    = 'numrow',
    description = 'Toggle tag',
    group       = 'tag',
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end
  },
  awful.key {
    modifiers   = { mod.super, mod.shift },
    keygroup    = 'numrow',
    description = 'Move focused client to tag',
    group       = 'tag',
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end
  },
  awful.key {
    modifiers   = { mod.super, mod.ctrl, mod.shift },
    keygroup    = 'numrow',
    description = 'Toggle focused client on tag',
    group       = 'tag',
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end
  },
  awful.key {
    modifiers   = { mod.super },
    keygroup    = 'numpad',
    description = 'Select layout directly',
    group       = 'layout',
    on_press    = function(index)
      local tag = awful.screen.focused().selected_tag
      if tag then
        tag.layout = tag.layouts[index] or tag.layout
      end
    end
  },

  -- Screenshot
  awful.key {
    modifiers   = { mod.super },
    key         = 'Print',
    description = 'Takes a screenshot',
    group       = 'miscelaneous',
    on_press    = screenshot.screen
  },
  awful.key {
    modifiers   = { mod.super, mod.shift },
    key         = 'Print',
    description = 'Takes a window screenshot',
    group       = 'miscelaneous',
    on_press    = screenshot.window
  },
  awful.key {
    modifiers   = {},
    key         = 'Print',
    description = 'Takes a selection screenshot',
    group       = 'miscelaneous',
    on_press    = screenshot.selection
  },

  -- Color picker
  awful.key {
    modifiers   = { mod.super },
    key         = 'o',
    description = 'Takes Color Picker',
    group       = 'miscelaneous',
    on_press    = function() awful.spawn(config_dir .. 'script/xcolor-pick') end
  },

  -- Volume
  awful.key({}, "XF86AudioRaiseVolume", function()
    volume.increase()
    awesome.emit_signal("open::osd")
  end),
  awful.key({}, "XF86AudioLowerVolume", function()
    volume.decrease()
    awesome.emit_signal("open::osd")
  end),
  awful.key({}, "XF86AudioMute", function()
    volume.mute()
    awesome.emit_signal("open::osd")
  end),

  -- Brightness
  awful.key({}, "XF86MonBrightnessUp", function()
    brightness.increase()
    awesome.emit_signal("open::osdb")
  end),

  awful.key({}, "XF86MonBrightnessDown", function()
    brightness.decrease()
    awesome.emit_signal("open::osdb")
  end),
}
