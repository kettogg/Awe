local wibox      = require("wibox")
local awful      = require("awful")
local colors     = require('widgets.exitscreen.module.colors')
local gears      = require('gears')
local beautiful  = require('beautiful')
local dpi        = beautiful.xresources.apply_dpi
local gfs        = gears.filesystem
local asset_path = gfs.get_configuration_dir() .. 'theme/assets/close/'
local helpers    = require('helpers')

return wibox.widget {
  {
    {
      {
        {
          widget = wibox.widget.imagebox,
          image = beautiful.avatar,
          forced_height = dpi(60),
          forced_width = dpi(60),
          align = "center",
          valign = "center",
          clip_shape = function(c, w, h)
            gears.shape.rounded_rect(c, w, h, dpi(40))
          end,
          resize = true,
        },
        widget = wibox.container.margin,
        left = 30
      },
      nil,
      {
        {
          {
            {
              font = beautiful.font_sans .. " 14",
              format = "%a, %d %B",
              align = "center",
              valign = "center",
              widget = wibox.widget.textclock
            },
            widget = wibox.container.margin,
            left = dpi(25),
            right = dpi(25),
          },
          widget = wibox.container.background,
        },
        {
          {
            {
              font = beautiful.icon_alt .. " 24",
              markup = helpers.colorizeText("󰅖", beautiful.red),
              valign = "center",
              widget = wibox.widget.textbox,
            },
            widget = wibox.container.margin,
            margins = dpi(20),
          },
          buttons = {
            awful.button({}, 1, function()
              awesome.emit_signal("toggle::exit")
            end)
          },
          widget = wibox.container.background,
        },
        spacing = dpi(20),
        layout = wibox.layout.fixed.horizontal,
      },
      layout = wibox.layout.align.horizontal,
    },
    widget = wibox.container.place,
    content_fill_horizontal = true,
    halign = "center",
    valign = "top",
  },
  widget = wibox.container.margin,
  top = dpi(40),
  left = dpi(40),
  right = dpi(40),
}
