local awful     = require("awful")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require("helpers")
local wibox     = require("wibox")
local gears     = require("gears")

local buttons   = require("widgets.sysetting.mods.buttons")
local moosic    = require("widgets.sysetting.mods.music")
local sliders   = require("widgets.sysetting.mods.slider")
local footer    = require("widgets.sysetting.mods.footer")
local mods      = require("widgets.sysetting.mods")

awful.screen.connect_for_each_screen(function(s)
  local sysetting = wibox({
    shape = helpers.rrect(2),
    screen = s,
    width = 660,
    height = 590,
    bg = beautiful.bg_normal .. "00",
    ontop = true,
    visible = false,
  })

  sysetting:setup {
    {
      {
        {
          {
            {
              layout = wibox.layout.align.horizontal,
              {
                {
                  widget = wibox.widget.imagebox,
                  image = beautiful.avatar,
                  forced_height = 70,
                  opacity = 0.7,
                  forced_width = 70,
                  clip_shape = helpers.rrect(70),
                  resize = true,
                },
                {
                  {
                    {
                      -- footer,
                      mods.smiley_bat(),
                      widget = wibox.container.place,
                      valign = "center",
                    },
                    widget = wibox.container.margin,
                    top = 0,
                    bottom = 0,
                    left = 10,
                    right = 10,
                  },
                  widget = wibox.container.background,
                  -- shape = helpers.rrect(2),
                  -- bg = beautiful.bg_light
                },
                layout = wibox.layout.fixed.horizontal,
                spacing = 20,
              },
              nil,
              {
                {
                  {
                    font = beautiful.icon .. " 24",
                    markup = helpers.colorizeText("", beautiful.fg_normal .. 'dd'),
                    widget = wibox.widget.textbox,
                    valign = "center",
                    align = "center"
                  },
                  widget = wibox.container.margin,
                  top = 0,
                  bottom = 0,
                  left = 10,
                  right = 10,
                },
                widget = wibox.container.background,
                shape = helpers.rrect(2),
                -- buttons = {
                --   awful.button({}, 1, function()
                --     awesome.emit_signal('toggle::setup')
                --   end)
                -- },
              },
            },
            widget = wibox.container.margin,
            top = 10,
          },
          sliders,
          buttons,
          layout = wibox.layout.fixed.vertical,
          spacing = 32,
        },
        widget = wibox.container.margin,
        top = 20,
        left = 30,
        right = 30,
        bottom = 40
      },
      widget = wibox.container.background,
      bg = beautiful.bg_normal,
      shape = helpers.rrect(0),
    },
    -- nil,
    layout = wibox.layout.align.vertical,
  }
  awful.placement.bottom_right(sysetting, { honor_workarea = true, margins = 88 })
  awesome.connect_signal("toggle::sysetting", function()
    sysetting.visible = not sysetting.visible
  end)
end)
