local wibox     = require("wibox")
local awful     = require("awful")
local gears     = require("gears")
local Gio       = require("lgi").Gio
local iconTheme = require("lgi").require("Gtk", "3.0").IconTheme.get_default()
local beautiful = require("beautiful")
local helpers   = require("helpers")
local animation = require("modules.animation")
local dpi       = beautiful.xresources.apply_dpi

awful.screen.connect_for_each_screen(function(s)
  local launcherdisplay = wibox {
    width = dpi(520),
    shape = helpers.rrect(3),
    height = dpi(590),
    bg = beautiful.bg_normal,
    ontop = true,
    visible = false
  }
  local prompt = wibox.widget {
    {
      image = helpers.cropSurface(2.758, gears.surface.load_uncached(beautiful.wallpaper)), -- pass the ratio here width/height
      opacity = 0.9,
      forced_height = dpi(174),
      clip_shape = helpers.rrect(4),
      forced_width = dpi(480),
      widget = wibox.widget.imagebox
    },
    {
      {
        {
          {
            {
              markup = " ",
              forced_height = 28,
              id = "search",
              font = beautiful.icon .. " 15",
              widget = wibox.widget.textbox,
            },
            {
              {
                markup = "Whatya looking ...",
                forced_height = 28,
                id = "placeholder",
                font = beautiful.font_sans .. "11",
                widget = wibox.widget.textbox,
              },
              widget = wibox.container.margin,
              left = 30,
            },
            {
              {
                markup = "",
                forced_height = 28,
                id = "txt",
                font = beautiful.font_sans .. "11",
                widget = wibox.widget.textbox,
              },
              widget = wibox.container.margin,
              left = 30,
            },
            layout = wibox.layout.stack
          },
          widget = wibox.container.margin,
          margins = 14,
        },
        forced_width = 340,
        shape = helpers.rrect(3),
        widget = wibox.container.background,
        bg = beautiful.bg_light
      },
      widget = wibox.container.place,
      halign = "center",
      valgn = "center",
    },
    layout = wibox.layout.stack
  }

  local entries = wibox.widget {
    homogeneous = false,
    expand = false,
    forced_num_cols = 1,
    spacing = 4,
    layout = wibox.layout.grid
  }
  local createPowerButton = function(icon, color, command)
    return wibox.widget {
      {
        {
          {
            markup = helpers.colorizeText(icon, color),
            align = "center",
            font = beautiful.icon .. " 20",
            widget = wibox.widget.textbox,
          },
          margins = 9,
          widget = wibox.container.margin
        },
        widget = wibox.container.background,
        bg = color .. '00',
        shape = helpers.rrect(2)
      },
      widget = wibox.container.place,
      halign = "center",
      buttons = {
        awful.button({}, 1, function()
          awesome.emit_signal("quit::search")
          awesome.emit_signal("quit::launcher")
          awful.spawn.with_shell(command)
        end)
      },
    }
  end
  launcherdisplay:setup {
    {
      {
        nil,
        -- {
        --   {
        --     {
        --       widget = wibox.widget.imagebox,
        --       image = beautiful.avatar,
        --       forced_height = 45,
        --       forced_width = 45,
        --       resize = true,
        --     },
        --     widget = wibox.container.place,
        --     halign = "center"
        --   },
        --   widget = wibox.container.margin,
        --   top = 20,
        -- },
        nil,
        {
          {
            createPowerButton("", beautiful.red .. 'dd', "poweroff"),
            createPowerButton("", beautiful.blue .. 'dd', "/home/" .. helpers.getUserName() .. "/.local/bin/lock"),
            createPowerButton("", beautiful.green .. 'dd', "reboot"),
            spacing = 10,
            layout = wibox.layout.fixed.vertical,
          },
          widget = wibox.container.margin,
          bottom = dpi(19),
        },
        layout = wibox.layout.align.vertical
      },
      widget = wibox.container.background,
      bg = beautiful.bg_light,
      forced_width = 90,
    },
    {
      {
        prompt,
        spacing = 10,
        entries,
        layout = wibox.layout.fixed.vertical
      },
      left = 10,
      right = 10,
      bottom = 10,
      top = 10,
      widget = wibox.container.margin
    },
    nil,
    spacing = 0,
    layout = wibox.layout.align.horizontal
  }

  -- Functions
  local function next(entries)
    if index_entry ~= #filtered then
      index_entry = index_entry + 1
      if index_entry > index_start + 5 then
        index_start = index_start + 1
      end
    end
  end

  local function back(entries)
    if index_entry ~= 1 then
      index_entry = index_entry - 1
      if index_entry < index_start then
        index_start = index_start - 1
      end
    end
  end

  local function gen()
    local entries = {}
    for _, entry in ipairs(Gio.AppInfo.get_all()) do
      if entry:should_show() then
        local name = entry:get_name():gsub("&", "&amp;"):gsub("<", "&lt;"):gsub("'", "&#39;")
        local icon = entry:get_icon()
        local path
        if icon then
          path = icon:to_string()
          if not path:find("/") then
            local icon_info = iconTheme:lookup_icon(path, dpi(64), 0)
            local p = icon_info and icon_info:get_filename()
            path = p
          end
        end
        table.insert(
          entries,
          { name = name, appinfo = entry, icon = path or '' }
        )
      end
    end
    return entries
  end

  local function filter(cmd)
    filtered = {}
    regfiltered = {}

    -- Filter entries

    for _, entry in ipairs(unfiltered) do
      if entry.name:lower():sub(1, cmd:len()) == cmd:lower() then
        table.insert(filtered, entry)
      elseif entry.name:lower():match(cmd:lower()) then
        table.insert(regfiltered, entry)
      end
    end

    -- Sort entries

    table.sort(filtered, function(a, b) return a.name:lower() < b.name:lower() end)
    table.sort(regfiltered, function(a, b) return a.name:lower() < b.name:lower() end)

    -- Merge entries

    for i = 1, #regfiltered do
      filtered[#filtered + 1] = regfiltered[i]
    end

    -- Clear entries

    entries:reset()

    -- Add filtered entries

    for i, entry in ipairs(filtered) do
      local widget = wibox.widget {
        {
          {
            {
              image = entry.icon,
              clip_shape = helpers.rrect(10),
              forced_height = dpi(32),
              forced_width = dpi(32),
              valign = 'center',
              widget = wibox.widget.imagebox
            },
            {
              markup = entry.name,
              id = "name",
              font = beautiful.font_sans .. " 11",
              widget = wibox.widget.textbox
            },
            spacing = 20,
            layout = wibox.layout.fixed.horizontal,
          },
          top = dpi(2),
          bottom = dpi(2),
          right = dpi(2),
          left = dpi(10),
          widget = wibox.container.margin
        },
        forced_width = dpi(480),
        forced_height = 80,
        widget = wibox.container.background
      }

      if index_start <= i and i <= index_start + 6 then
        entries:add(widget)
      end

      if i == index_entry then
        widget.bg = beautiful.blue .. "09"
        widget:get_children_by_id("name")[1].markup = helpers.colorizeText(entry.name, beautiful.blue)
      end
    end

    -- Fix position

    if index_entry > #filtered then
      index_entry, index_start = 1, 1
    elseif index_entry < 1 then
      index_entry = 1
    end

    collectgarbage("collect")
  end

  local exclude = {
    "Shift_R",
    "Shift_L",
    "Super_R",
    "Super_L",
    "Tab",
    "Alt_R",
    "Alt_L",
    "Ctrl_L",
    "Ctrl_R",
    "CapsLock",
    "Home",
    "Down",
    "Up",
    "Left",
    "Right",
    "Print"
  }
  local function has_value(tab, val)
    for _, value in ipairs(tab) do
      if value == val then
        return true
      end
    end

    return false
  end
  local prompt_grabber = awful.keygrabber({
    auto_start = true,
    stop_event = "release",
    keypressed_callback = function(self, mod, key, command)
      local addition = ''
      if key == "Escape" then
        awesome.emit_signal("quit::search")
        awesome.emit_signal("quit::launcher")
      elseif key == "BackSpace" then
        prompt:get_children_by_id('txt')[1].markup = prompt:get_children_by_id('txt')[1].markup:sub(1, -2)
        filter(prompt:get_children_by_id('txt')[1].markup)
      elseif key == "Return" then
        local entry = filtered[index_entry]
        if entry then
          entry.appinfo:launch()
        else
          awful.spawn.with_shell(prompt:get_children_by_id('txt')[1].markup)
        end
        awesome.emit_signal("quit::search")
        awesome.emit_signal("quit::launcher")
      elseif key == "Up" then
        back(entries)
      elseif key == "Down" then
        next(entries)
      elseif has_value(exclude, key) then
        addition = ''
      else
        addition = key
      end
      prompt:get_children_by_id('txt')[1].markup = prompt:get_children_by_id('txt')[1].markup .. addition
      filter(prompt:get_children_by_id('txt')[1].markup)
      if string.len(prompt:get_children_by_id('txt')[1].markup) > 0 then
        prompt:get_children_by_id('placeholder')[1].markup = ''
      else
        prompt:get_children_by_id('placeholder')[1].markup = 'Whatya looking ...'
      end
    end,
  })
  awesome.connect_signal("toggle::search", function()
    prompt_grabber:start()
  end)

  awesome.connect_signal("quit::search", function()
    prompt_grabber:stop()
    prompt:get_children_by_id('txt')[1].markup = ""
  end)
  local function open()
    -- Reset index and page

    index_start, index_entry = 1, 1

    -- Get entries

    unfiltered = gen()
    filter("")

    -- Prompt
    awesome.emit_signal("toggle::search")
  end

  awesome.connect_signal("quit::launcher", function()
    launcherdisplay.visible = false
  end)
  awesome.connect_signal("toggle::launcher", function()
    open()
    if launcherdisplay.visible then
      awesome.emit_signal("quit::search")
    end
    launcherdisplay.visible = not launcherdisplay.visible
    awful.placement.bottom_left(
      launcherdisplay,
      { honor_workarea = true, margins = { bottom = 20, left = 20 } }
    )
  end)
end)
