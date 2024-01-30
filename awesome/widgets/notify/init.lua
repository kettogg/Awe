local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local wibox = require("wibox")
local gears = require("gears")
local empty = require("widgets.notify.mods.empty")
local make = require("widgets.notify.mods.make")
local progs = require("widgets.notify.mods.progs")

awful.screen.connect_for_each_screen(function(s)
  local notify = wibox({
    shape = helpers.rrect(2),
    screen = s,
    width = 600,
    height = 1600 - 40 - 70,
    bg = beautiful.bg_normal,
    ontop = true,
    visible = false,
  })


  local finalcontent = wibox.widget {
    layout = require('modules.overflow').vertical,
    scrollbar_enabled = false,
    spacing = 20,
  }
  finalcontent:insert(1, empty)

  local remove_notifs_empty           = true

  notif_center_reset_notifs_container = function()
    finalcontent:reset(finalcontent)
    finalcontent:insert(1, empty)
    remove_notifs_empty = true
  end

  notif_center_remove_notif           = function(box)
    finalcontent:remove_widgets(box)
    if #finalcontent.children == 0 then
      finalcontent:insert(1, empty)
      remove_notifs_empty = true
    end
  end


  local clearButton = wibox.widget {
    font = beautiful.icon .. " 26",
    markup = helpers.colorizeText("", beautiful.red),
    widget = wibox.widget.textbox,
    valign = "center",
    align = "center",
    buttons = {
      awful.button({}, 1, function()
        notif_center_reset_notifs_container()
      end)
    }
  }
  naughty.connect_signal("request::display", function(n)
    if #finalcontent.children == 1 and remove_notifs_empty then
      finalcontent:reset(finalcontent)
      remove_notifs_empty = false
    end

    local appicon = n.icon or n.app_icon
    if not appicon then
      appicon = gears.filesystem.get_configuration_dir() .. "theme/assets/awesome.svg"
    end
    finalcontent:insert(1, make(appicon, n))
  end)
  notify:setup {
    {
      {
        {
          {
            {
              markup = helpers.colorizeText("Notifications", beautiful.fg_normal),
              halign = 'center',
              font   = beautiful.font_sans .. " 14",
              widget = wibox.widget.textbox
            },
            nil,
            clearButton,
            widget = wibox.layout.align.horizontal,
          },
          widget = wibox.container.margin,
          margins = 20,
        },
        widget = wibox.container.background,
        bg = beautiful.bg_light
      },
      {
        {
          finalcontent,
          widget = wibox.container.margin,
          margins = 20,
        },
        widget = wibox.container.background,
      },
      progs,
      layout = wibox.layout.align.vertical,
      spacing = 20,
    },
    widget = wibox.container.margin,
    margins = 0,
  }
  awful.placement.bottom_right(notify, { honor_workarea = true, margins = { bottom = 88, right = 16 } })
  awesome.connect_signal("toggle::notify", function()
    notify.visible = not notify.visible
  end)
end)
