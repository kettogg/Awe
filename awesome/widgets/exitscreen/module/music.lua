local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local gears     = require("gears")
local pctl      = require("modules.playerctl")
local helpers   = require("helpers")
local playerctl = pctl.lib()

local art       = wibox.widget {
  image = helpers.cropSurface(1, gears.surface.load_uncached(beautiful.songdefpicture_alt)),
  forced_height = dpi(45),
  clip_shape = helpers.rrect(45),
  forced_width = dpi(45),
  widget = wibox.widget.imagebox,
  valign = 'center',
}

local songname  = wibox.widget {
  markup = helpers.colorizeText('Nothing Playing', beautiful.fg_normal),
  align = 'left',
  valign = 'center',
  font = beautiful.font_sans .. " 14",
  widget = wibox.widget.textbox
}

local widget    = wibox.widget {
  {
    art,
    songname,
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
  },
  widget = wibox.container.background,
  -- bg = beautiful.bg_normal
}

playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
  if album_path == "" then
    album_path = beautiful.songdefpicture_alt
  end
  if string.len(title) > 30 then
    title = string.sub(title, 0, 30) .. "..."
  end
  if string.len(artist) > 22 then
    artist = string.sub(artist, 0, 22) .. "..."
  end
  songname:set_markup_silently(helpers.colorizeText(title or "NO", beautiful.fg_normal))
  art:set_image(helpers.cropSurface(1, gears.surface.load_uncached(album_path)))
end)

return widget
