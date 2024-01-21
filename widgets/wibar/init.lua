local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require('helpers')
-- local modules   = require(... .. '.module')
local mods      = require(... .. '.mods')

return function(s)
  return awful.wibar {
    screen = s,
    position = "bottom",
    height = dpi(45),
    widget = {
      {
        {
          {
            mods.me(),
            mods.layout(),
            mods.theme_switch(),
            {
              {
                mods.tags(s),
                widget = wibox.container.margin,
                left = 15,
                right = 15,
              },
              shape = helpers.rrect(2),
              widget = wibox.container.background,
              bg = beautiful.bg_light,
            },
            spacing = 14,
            layout = wibox.layout.fixed.horizontal
          },
          widget = wibox.container.place,
          valign = "center"
        },
        widget = wibox.container.margin,
        left = 15,
      },
      {
        {
          {
            mods.tasks(s),
            widget = wibox.container.margin,
            margins = dpi(4),
          },
          widget = wibox.container.place,
          valign = "center",
          halign = "left",
        },
        widget = wibox.container.margin,
        left = 0,
      },
      {
        {
          {
            mods.systray(),
            mods.music(),
            {
              {
                {
                  mods.battery(),
                  mods.wifi(),
                  mods.bluetooth(),
                  spacing = 16,
                  layout = wibox.layout.fixed.horizontal
                },
                widget = wibox.container.margin,
                top = 10,
                bottom = 10,
                left = 16,
                right = 16
              },
              widget = wibox.container.background,
              shape = helpers.rrect(2),
              bg = beautiful.bg_light,
              buttons = {
                awful.button({}, 1, function()
                  awesome.emit_signal('toggle::sysetting')
                end)
              },
            },
            mods.time(),
            {
              {
                {
                  {
                    align = 'center',
                    font = beautiful.icon .. " 15",
                    markup = helpers.colorizeText('', beautiful.fg_normal),
                    widget = wibox.widget.textbox,
                    buttons = {
                      awful.button({}, 1, function()
                        awesome.emit_signal('toggle::notify')
                      end)
                    },
                  },
                  {
                    align = 'center',
                    font = beautiful.icon .. " 16",
                    markup = helpers.colorizeText(' ', beautiful.red),
                    widget = wibox.widget.textbox,
                    buttons = {
                      awful.button({}, 1, function()
                        awesome.emit_signal('toggle::exit')
                      end)
                    },
                  },
                  spacing = 16,
                  layout = wibox.layout.fixed.horizontal
                },
                widget = wibox.container.margin,
                top = 10,
                bottom = 10,
                left = 16,
                right = 10
              },
              widget = wibox.container.background,
              shape = helpers.rrect(2),
              bg = beautiful.bg_light,
            },
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
          },
          widget = wibox.container.place,
          valign = "center",
        },
        widget = wibox.container.margin,
        right = 8,
      },
      layout = wibox.layout.align.horizontal,
    }
    -- screen = s,
    -- position = 'top',
    -- height = dpi(50),
    -- widget = {
    --    widget = wibox.container.background,
    --    bg = modules.colors.bg_normal,
    --    {
    --       widget = wibox.container.margin,
    --       margins = {
    --          left = dpi(5),
    --          right = dpi(5),
    --          top = dpi(10),
    --          bottom = dpi(10)
    --       },
    --       {
    --          layout = wibox.layout.align.horizontal,
    --          {
    --             layout = wibox.layout.fixed.horizontal,
    --             spacing = dpi(10),
    --             modules.distro_icon(),
    --             modules.taglist(s),
    --          },
    --          {
    --             widget = wibox.container.margin,
    --             margins = {
    --                top = dpi(5)
    --             },
    --             modules.tasklist(s),
    --          },
    --          {
    --             layout = wibox.layout.fixed.horizontal,
    --             spacing = dpi(10),
    --             modules.systray(),
    --             modules.search(),
    --             modules.battery,
    --             modules.wifi(),
    --             modules.clock(),
    --             modules.layoutbox(),
    --             modules.shutdown_icon()
    --          }
    --       }
    --    }
    -- }
  }
end
