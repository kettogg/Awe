local awful     = require("awful")
local helpers   = require("helpers")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local scheme    = require('config.user').colorscheme
local mods      = require(... .. '.mods')

local themer    = wibox {
  ontop   = true,
  visible = false,
  width   = dpi(309),
  height  = dpi(414),
  bg      = mods.colors.bg_normal,
  shape   = function(c, w, h)
    gears.shape.rounded_rect(c, w, h, dpi(2))
  end,
  widget  = {
    {
      {
        -- Header
        {
          mods.header,
          layout = wibox.layout.fixed.horizontal
        },
        -- Middle

        -- Bottom
        mods.switcher,
        {
          mods.maim,
          layout = wibox.layout.fixed.horizontal
        },
        spacing = dpi(15),
        layout = wibox.layout.fixed.vertical
      },
      spacing = dpi(28),
      layout = wibox.layout.fixed.horizontal
    },
    margins = { left = dpi(14), right = dpi(14), top = dpi(18) },
    widget = wibox.container.margin
  }
}

awful.placement.bottom_left(themer, { honor_workarea = true, margins = { bottom = 88, left = 78 } })

function themer:show()
  themer.visible = not themer.visible
end

return themer
