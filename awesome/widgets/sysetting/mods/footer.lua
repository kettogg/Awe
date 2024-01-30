local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local awful = require("awful")

local widget = wibox.widget {
  {
    {
      max_value        = 100,
      value            = 69,
      id               = "prog",
      forced_height    = 20,
      forced_width     = 50,
      paddings         = 3,
      border_color     = beautiful.fg_normal .. "99",
      background_color = beautiful.bg_normal,
      bar_shape        = helpers.rrect(2),
      color            = beautiful.blue,
      border_width     = 1.25,
      shape            = helpers.rrect(4),
      widget           = wibox.widget.progressbar
    },
    {
      {
        bg = beautiful.fg_normal .. "99",
        forced_height = 10,
        forced_width = 2,
        shape = helpers.rrect(10),
        widget = wibox.container.background,
      },
      widget = wibox.container.place,
      valign = "center",
    },
    spacing = 3,
    layout = wibox.layout.fixed.horizontal

  },
  {
    font = beautiful.font_sans .. " 12",
    markup = helpers.colorizeText("25%", beautiful.fg_normal),
    valign = "center",
    id = "batvalue",
    widget = wibox.widget.textbox,
  },
  layout = wibox.layout.fixed.horizontal,
  spacing = 10
}
awesome.connect_signal("signal::bat", function(value)
  local b = widget:get_children_by_id("prog")[1]
  local v = widget:get_children_by_id("batvalue")[1]
  -- print(value)
  v.markup = helpers.colorizeText(value .. "%", beautiful.fg_normal)
  b.value = value
  if value > 80 then
    b.color = beautiful.green
  elseif value > 20 then
    b.color = beautiful.blue
  else
    b.color = beautiful.red
  end
end)

return widget
