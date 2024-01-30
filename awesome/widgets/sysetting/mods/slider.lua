local wibox           = require("wibox")
local awful           = require("awful")
local beautiful       = require("beautiful")
local dpi             = require("beautiful").xresources.apply_dpi
local gears           = require("gears")
local helpers         = require("helpers")

-- Progressbar
local brightness      = wibox.widget {
  widget = wibox.widget.slider,
  value = 50,
  maximum = 100,
  forced_width = dpi(300),
  shape = gears.shape.rounded_bar,
  bar_shape = gears.shape.rounded_bar,
  bar_color = beautiful.fg_normal .. '1a',
  bar_margins = { bottom = dpi(20), top = dpi(20) },
  bar_active_color = beautiful.fg_normal,
  handle_width = dpi(16),
  handle_shape = gears.shape.circle,
  handle_color = beautiful.bg_normal,
  handle_border_width = 2,
  handle_border_color = beautiful.fg_normal
}

local brightness_icon = wibox.widget {
  widget = wibox.widget.textbox,
  markup = helpers.colorizeText("明", beautiful.fg_normal),
  font = beautiful.icon_alt .. " 16",
  align = "center",
  valign = "center"
}

local brightness_text = wibox.widget {
  widget = wibox.widget.textbox,
  markup = helpers.colorizeText("10%", beautiful.fg_normal),
  font = beautiful.font_nerd .. " 13",
  align = "center",
  valign = "center"
}

local bright_init     = wibox.widget {
  brightness_icon,
  brightness,
  brightness_text,
  layout = wibox.layout.fixed.horizontal,
  forced_height = dpi(42),
  spacing = dpi(17)
}

awful.spawn.easy_async_with_shell("brightnessctl | grep -i  'current' | awk '{ print $4}' | tr -d \"(%)\"",
  function(stdout)
    local value = string.gsub(stdout, '^%s*(.-)%s*$', '%1')
    brightness.value = tonumber(value)
    brightness_text.markup = helpers.colorizeText(value .. "%", beautiful.fg_normal)
  end)

brightness:connect_signal("property::value", function(_, new_value)
  brightness_text.markup = helpers.colorizeText(new_value .. "%", beautiful.fg_normal)
  brightness.value = new_value
  awful.spawn("brightnessctl set " .. new_value .. "%", false)
end)

-- Volume
local volume = wibox.widget {
  widget = wibox.widget.slider,
  value = 50,
  maximum = 100,
  forced_width = dpi(300),
  shape = gears.shape.rounded_bar,
  bar_shape = gears.shape.rounded_bar,
  bar_color = beautiful.fg_normal .. '1a',
  bar_margins = { bottom = dpi(20), top = dpi(20) },
  bar_active_color = beautiful.fg_normal,
  handle_width = dpi(16),
  handle_shape = gears.shape.circle,
  handle_color = beautiful.bg_normal,
  handle_border_width = 2,
  handle_border_color = beautiful.fg_normal
}
-- 音
local volume_icon = wibox.widget {
  widget = wibox.widget.textbox,
  markup = helpers.colorizeText("音", beautiful.fg_normal),
  font = beautiful.icon_alt .. " 16",
  align = "center",
  valign = "center"
}

local volume_text = wibox.widget {
  widget = wibox.widget.textbox,
  markup = helpers.colorizeText("10%", beautiful.fg_normal),
  font = beautiful.font_nerd .. " 13",
  align = "center",
  valign = "center"
}

local volume_init = wibox.widget {
  volume_icon,
  volume,
  volume_text,
  layout = wibox.layout.fixed.horizontal,
  forced_height = dpi(42),
  spacing = dpi(17)
}

awful.spawn.easy_async_with_shell("amixer get Master | tail -n 1 | awk '{print $5}' | tr -d '[%]'",
  function(stdout)
    local value = string.gsub(stdout, '^%s*(.-)%s*$', '%1')
    volume.value = tonumber(value)
    volume_text.markup = helpers.colorizeText(value .. "%", beautiful.fg_normal)
  end)

volume:connect_signal("property::value", function(_, new_value)
  volume_text.markup = helpers.colorizeText(new_value .. "%", beautiful.fg_normal)
  volume.value = new_value
  awful.spawn("amixer set Master " .. new_value .. "%", false)
end)

return wibox.widget {
  {
    bright_init,
    volume_init,
    spacing = dpi(0),
    layout = wibox.layout.fixed.vertical,
  },
  margins = { top = dpi(0), bottom = dpi(4), left = dpi(4), right = dpi(4) },
  widget = wibox.container.margin
}
