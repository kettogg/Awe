local wibox     = require("wibox")
local colors    = require('widgets.exitscreen.module.colors')
local gears     = require('gears')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local widget    = wibox.widget {
  {
    {
      max_value        = 100,
      value            = 69,
      id               = "prog",
      forced_height    = dpi(32),
      forced_width     = dpi(76),
      paddings         = dpi(0),
      border_color     = colors.fg_normal .. "99",
      background_color = colors.bg_normal,
      bar_shape        = function(c, w, h)
        gears.shape.rounded_rect(c, w, h, dpi(16))
      end,
      color            = colors.blue,
      shape            = function(c, w, h)
        gears.shape.rounded_rect(c, w, h, dpi(20))
      end,
      widget           = wibox.widget.progressbar,
      valign           = 'center',
    },
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(8),
    {
      font = beautiful.font_sans .. " 14",
      markup = "<span foreground='" .. colors.blue .. "'>25%</span>",
      valign = "center",
      id = "batvalue",
      widget = wibox.widget.textbox,
    },
  },
  widget = wibox.container.margin,
  margins = { top = dpi(24), bottom = dpi(24) }
}

awesome.connect_signal('signal::battery', function(level, state, _, _, _)
  local progresss = widget:get_children_by_id("prog")[1]
  local text = widget:get_children_by_id("batvalue")[1]
  text.markup = "<span foreground='" .. colors.fg_normal .. "'>" .. level .. '%' .. "</span>"
  progresss.value = level
  if level > 80 then
    progresss.color = colors.green
  elseif level > 20 then
    progresss.color = colors.blue
  else
    progresss.color = colors.red
  end
end)

return widget
