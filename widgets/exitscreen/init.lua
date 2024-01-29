local awful      = require('awful')
local wibox      = require('wibox')
local beautiful  = require('beautiful')
local dpi        = beautiful.xresources.apply_dpi
local colors     = require('widgets.exitscreen.module.colors')
local modules    = require('widgets.exitscreen.module')
local gears      = require('gears')
local gfs        = gears.filesystem
local asset_path = gfs.get_configuration_dir() .. 'theme/assets/exitscreen/'
local helpers    = require('helpers')

local function recolorImage(image, color)
  return gears.color.recolor_image(image, color)
end

local icon = {
  powerofficon = recolorImage(asset_path .. "poweroff.svg", colors.red),
  rebooticon = recolorImage(asset_path .. "reboot.svg", colors.blue),
  exiticon = recolorImage(asset_path .. "exit.svg", colors.yellow),
  suspendicon = recolorImage(asset_path .. "suspend.svg", colors.cyan)
}

local poweroffcommand = function()
  awful.spawn.with_shell('systemctl poweroff')
  awesome.emit_signal('hide::exit')
end

local rebootcommand = function()
  awful.spawn.with_shell('systemctl reboot')
  awesome.emit_signal('hide::exit')
end

local suspendcommnad = function()
  awesome.emit_signal('hide::exit')
  awful.spawn.with_shell("systemctl suspend")
end

local exitcommand = function()
  awesome.quit()
end

local lockcommand = function()
  awesome.emit_signal('hide::exit')
  awful.spawn.with_shell("/home/re1san/.local/bin/lock")
end

local createButton = function(icon, cmd, color)
  local button = wibox.widget {
    {

      {
        {
          id     = "image",
          markup = helpers.colorizeText(icon, color),
          font   = beautiful.icon_alt .. " 50",
          align  = "center",
          widget = wibox.widget.textbox,
        },
        -- {
        --   id = "image",
        --   image = recolorImage(icon, color),
        --   widget = wibox.widget.imagebox,
        --   resize = false,

        -- },
        id = "icon_layout",
        halign = 'center',
        valign = "center",
        widget = wibox.container.place
      },
      margins = {
        left = dpi(58), right = dpi(58),
        top = dpi(34), bottom = dpi(34)
      },
      widget = wibox.container.margin
    },
    shape = helpers.rrect(2),
    widget = wibox.container.background,
    bg = colors.bg_normal,
    shape_border_color = color,
    shape_border_width = dpi(1),
    buttons = {
      awful.button({}, 1, function()
        cmd()
      end)
    },
  }
  button:connect_signal('mouse::enter', function(self)
    self.bg = color
    self:get_children_by_id('image')[1].markup = helpers.colorizeText(icon, colors.bg_normal)
  end)
  button:connect_signal('mouse::leave', function(self)
    self.bg = colors.bg_normal
    self:get_children_by_id('image')[1].markup = helpers.colorizeText(icon, color)
  end)
  return button
end

local poweroffbutton = createButton("󰐥", poweroffcommand, colors.red)
local rebootbutton = createButton("󰑐", rebootcommand, colors.blue)
local exitbutton = createButton("󰈆", exitcommand, colors.magenta)
local suspendbutton = createButton("󰖔", suspendcommnad, colors.cyan)
local lockbutton = createButton("", lockcommand, colors.yellow)

local box = wibox.widget {
  {
    {
      poweroffbutton,
      rebootbutton,
      lockbutton,
      suspendbutton,
      exitbutton,
      layout = wibox.layout.fixed.horizontal,
      spacing = 40,
    },
    spacing = 20,
    layout = wibox.layout.fixed.vertical
  },
  widget = wibox.container.place,
  halign = 'center',
}
local exit_screen_grabber = awful.keygrabber({
  auto_start = true,
  stop_event = 'release',
  keypressed_callback = function(self, mod, key, command)
    if key == 'e' then
      exitcommand()
    elseif key == 'p' then
      poweroffcommand()
    elseif key == 's' then
      suspendcommnad()
    elseif key == 'r' then
      rebootcommand()
    elseif key == 'Escape' or key == 'q' or key == 'x' then
      awesome.emit_signal('hide::exit')
    end
  end,
})

local footer = wibox.widget {
  {

    {
      modules.music,
      modules.time,
      modules.battery,
      spacing = 36,
      layout = wibox.layout.fixed.horizontal
    },
    widget = wibox.container.place,
    halign = 'center',
    valign = 'bottom'
  },
  widget = wibox.container.margin,
  bottom = 64,
}

-- awful.placement.bottom(footer)

return function(s)
  local exit = wibox({
    type = 'dock',
    screen = s,
    height = s.geometry.height,
    width = s.geometry.width,
    bg = colors.bg_normal .. '00',
    ontop = true,
    visible = false,
  })

  local back = wibox.widget {
    id = "bg",
    image = beautiful.wallpaper,
    widget = wibox.widget.imagebox,
    forced_height = s.geometry.height,
    horizontal_fit_policy = "fit",
    vertical_fit_policy = "fit",
    forced_width = s.geometry.width,
  }
  local overlay = wibox.widget {
    widget = wibox.container.background,
    forced_height = s.geometry.height,
    forced_width = s.geometry.width,
    bg = beautiful.bg_normal .. "d1"
  }
  local makeImage = function()
    local cmd = 'convert ' ..
        beautiful.wallpaper .. ' -filter Gaussian -blur 0x6 ~/.cache/awesome/exit.jpg'
    awful.spawn.easy_async_with_shell(cmd, function()
      local blurwall = gears.filesystem.get_cache_dir() .. "exit.jpg"
      back.image = blurwall
    end)
  end
  makeImage()

  exit:setup {
    back,
    overlay,
    modules.topbar,
    box,
    footer,
    widget = wibox.layout.stack
    -- layout = wibox.layout.align.vertical,
  }

  awesome.connect_signal('toggle::exit', function()
    if exit.visible then
      exit_screen_grabber:stop()
      exit.visible = false
    else
      exit.visible = true
      exit_screen_grabber:start()
    end
  end)

  awesome.connect_signal('show::exit', function()
    exit_screen_grabber:start()
    exit.visible = true
  end)

  awesome.connect_signal('hide::exit', function()
    exit_screen_grabber:stop()
    exit.visible = false
  end)

  return exit
end
