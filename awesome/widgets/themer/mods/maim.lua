local wibox        = require("wibox")
local helpers      = require("helpers")
local awful        = require("awful")
local beautiful    = require("beautiful")
local lgi          = require('lgi')
local Gtk          = lgi.require('Gtk', '3.0')
local Gdk          = lgi.require('Gdk', '3.0')
local GdkPixbuf    = lgi.GdkPixbuf

local delay        = tostring(1) .. " "
local clipboard    = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)

local getName      = function()
  local string = "~/Pictures/Screenshots/" .. os.date("%d-%m-%Y-%H:%M:%S") .. ".jpg"
  string = string:gsub("~", os.getenv("HOME"))
  return string
end

local defCommand   = "maim " .. "-d " .. delay

local copyScrot    = function(path)
  local image = GdkPixbuf.Pixbuf.new_from_file(path)
  clipboard:set_image(image)
  clipboard:store()
end

local createButton = function(icon, name, fn, col)
  return wibox.widget {
    {
      {
        {
          font = beautiful.icon .. " 40",
          markup = helpers.colorizeText(icon, col),
          valign = "center",
          align = "center",
          widget = wibox.widget.textbox,
        },
        widget = wibox.container.margin,
        margins = { left = 25, right = 25 }
      },
      {
        font = beautiful.font_sans .. " 11",
        markup = "<span alpha='97%' foreground='" .. beautiful.fg_normal .. "'>" .. name .. "</span>",
        valign = "center",
        align = "center",
        widget = wibox.widget.textbox,
      },
      spacing = 10,
      layout = wibox.layout.fixed.vertical,
    },
    layout = wibox.layout.fixed.vertical,
    buttons = awful.button({}, 1, function()
      fn()
    end),
  }
end

local fullscreen   = createButton('', 'Fullscreen', function()
  local name = getName()
  local cmd = defCommand .. name
  awful.spawn.easy_async_with_shell(cmd, function()
    copyScrot(name)
  end)
end, beautiful.green)

local selection    = createButton('', 'Selection', function()
  local name = getName()
  local cmd = "maim" .. " -s " .. name
  awful.spawn.easy_async_with_shell(cmd, function()
    copyScrot(name)
  end)
end, beautiful.blue)

local window       = createButton('', 'Window', function()
  local name = getName()
  local cmd = "maim" .. " -i " .. client.focus.window .. " " .. name
  awful.spawn.with_shell(cmd)
  awful.spawn.easy_async_with_shell(cmd, function()
    copyScrot(name)
  end)
end, beautiful.red)

return wibox.widget {
  {
    {
      -- {
      --   {
      --     {
      --       font = beautiful.font_sans .. " 12",
      --       markup = "<span foreground='" .. beautiful.fg_normal .. "'>" .. "Shotter" .. "</span>",
      --       valign = "center",
      --       align = "start",
      --       widget = wibox.widget.textbox,
      --     },
      --     widget = wibox.container.margin,
      --     margins = { bottom = 6, left = 12 }
      --   },
      --   widget = wibox.container.background,
      -- },
      {
        {
          fullscreen,
          selection,
          window,
          spacing = 25,
          layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.place,
        halign = "center"
      },
      spacing = 0,
      layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.margin,
    margins = { left = 34, right = 34, bottom = 54, top = 46 }
  },
  widget = wibox.container.background,
  shape = helpers.rrect(2),
  bg = beautiful.bg_light
}
