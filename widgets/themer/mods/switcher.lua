local awful      = require("awful")
local helpers    = require("helpers")
local wibox      = require("wibox")
local gears      = require("gears")
local beautiful  = require("beautiful")
local colors     = require('widgets.themer.mods.colors')
local dpi        = beautiful.xresources.apply_dpi
local scheme     = require('config.user').colorscheme
local gfs        = gears.filesystem
local asset_path = gfs.get_configuration_dir() .. 'theme/assets/'

local themes     = {
  'everblush',
  'everforest',
  'tokyonight',
  'fullerene',
  'oxocarbon',
  'catppuccin',
  'dracula',
  'rose',
  'mar',
  'nord',
  'gruvbox_dark',
  'gruvbox_light',
  'solarized_dark',
  'solarized_light',
  'plata',
  'adwaita',
  'janleigh',
  'default',
  'wave',
  'ephemeral',
  'amarena',
  'skyfall',
  'biscuit',
  'tsuki'
}

local index      = helpers.indexOf(themes, scheme)

local M          = {
  current = scheme,
  colors = {
    red = colors.red,
    green = colors.green,
    yellow = colors.yellow,
    blue = colors.blue,
    magenta = colors.magenta,
    bg = colors.bg_light,
    fg = colors.fg_normal
  }
}

function M:previous()
  index = index - 1
  if index < 1 then
    index = #themes
  end
  M:getColors(themes[index])
  M:setColors()
end

function M:next()
  index = index + 1
  if index > #themes then
    index = 1
  end
  M:getColors(themes[index])
  M:setColors()
end

function M:getColors(scheme)
  scheme       = scheme or self.current
  local colors = require("theme.colorscheme." .. scheme)
  self.colors  = colors
  self.current = scheme
end

function M:setColors()
  self.widget:get_children_by_id("red")[1].bg = self.colors.red
  self.widget:get_children_by_id("blue")[1].bg = self.colors.blue
  self.widget:get_children_by_id("green")[1].bg = self.colors.green
  self.widget:get_children_by_id("yellow")[1].bg = self.colors.yellow
  self.widget:get_children_by_id("magenta")[1].bg = self.colors.magenta
  self.widget:get_children_by_id("bg")[1].bg = self.colors.bg_light
  self.widget:get_children_by_id("name")[1].markup = "<span alpha='95%' foreground='" ..
      beautiful.fg_normal .. "'>" .. self.current:gsub("^%l", string.upper) .. "</span>"
end

function M.createButton(icon, action)
  local textbox = {
    id     = "image",
    markup = "<span alpha='70%' foreground='" .. colors.fg_normal .. "'>" .. icon .. "</span>",
    font   = beautiful.icon .. " 18",
    widget = wibox.widget.textbox
  }

  local widget = wibox.widget {
    {
      textbox,
      widget = wibox.container.margin,
    },
    id     = "icon_layout",
    bg     = colors.transparent,
    shape  = function(c, w, h)
      gears.shape.rounded_rect(c, w, h, dpi(2))
    end,
    widget = wibox.container.background,
  }

  local navigator = widget:get_children_by_id("image")[1]
  navigator:connect_signal('mouse::enter', function()
    navigator.markup = "<span alpha='90%' foreground='" .. colors.fg_light .. "'>" .. icon .. "</span>"
  end)
  navigator:connect_signal('mouse::leave', function()
    navigator.markup = "<span alpha='70%' foreground='" .. colors.fg_normal .. "'>" .. icon .. "</span>"
  end)

  widget.buttons = {
    awful.button(nil, 1, action)
  }

  return widget
end

function M.open_file(text, line, path)
  local file = io.open(path, 'r')
  local fileContent = {}

  for line in file:lines() do
    table.insert(fileContent, line)
  end

  io.close(file)

  fileContent[line] = text

  file = io.open(path, 'w')
  for index, value in ipairs(fileContent) do
    file:write(value .. '\n')
  end
  io.close(file)
end

function M.set_theme(current)
  M.open_file('   colorscheme = "' .. current:gsub('"', '\\"') .. '",', 21,
    gfs.get_configuration_dir() .. "config/user.lua") --Change theme
  -- M.open_file("include " .. current .. ".ini", 3, os.getenv("HOME") .. "/.config/kitty/kitty.conf")                          --Change terminal color (kitty)
  -- M.open_file('@import "'..current:gsub('"', '\\"') .. '.rasi"',1,os.getenv("HOME") .. "/.config/rofi/appmnu.rasi") --Change rofi color
  awesome.restart()
end

M.widget = wibox.widget {
  {
    {
      {
        {
          {
            {
              id     = "name",
              markup = "<span alpha='95%' foreground='" .. beautiful.fg_normal .. "'>" .. M.current:gsub("^%l", string.upper) .. "</span>",
              font   = beautiful.font_sans .. " 12",
              widget = wibox.widget.textbox
            },
            widget = wibox.container.margin,
            buttons = awful.button({}, 1, function()
              M:getColors(scheme)
              M:setColors()
            end),
          },
          id     = "bg_title",
          bg     = colors.transparent,
          shape  = function(c, w, h)
            gears.shape.rounded_rect(c, w, h, dpi(2))
          end,
          widget = wibox.container.background,
        },
        nil,
        {
          M.createButton('', function() M:previous() end),
          M.createButton('', function() M:next() end),
          M.createButton('', function() M.set_theme(M.current) end),
          spacing = dpi(10),
          layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal
      },
      {
        {
          {
            id = "red",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.red
          },
          {
            id = "green",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.green
          },
          {
            id = "yellow",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.yellow
          },
          {
            id = "blue",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.blue
          },
          {
            id = "magenta",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.magenta
          },
          spacing = 8,
          layout = wibox.layout.fixed.horizontal,
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      nil,
      layout = wibox.layout.align.vertical,
    },
    widget = wibox.container.margin,
    margins = { top = dpi(30), bottom = dpi(20), left = dpi(30), right = dpi(30) }
  },
  id = "bg",
  forced_height = dpi(160),
  shape = helpers.rrect(2),
  widget = wibox.container.background,
  bg = M.colors.bg,
}

M:getColors(scheme)
M:setColors()


-- local bg_title = M.widget:get_children_by_id("bg_title")[1]
-- local name = M.widget:get_children_by_id("name")[1]

-- name:connect_signal('mouse::enter', function()
--   name.markup = "<span alpha='90%' foreground='" ..
--   colors.fg_light .. "'>" .. M.current:gsub("^%l", string.upper) .. "</span>"
--   -- bg_title.bg = colors.mid_normal
-- end)

-- name:connect_signal('mouse::leave', function()
--   name.markup = "<span alpha='80%' foreground='" ..
--   colors.fg_normal .. "'>" .. M.current:gsub("^%l", string.upper) .. "</span>"
-- end)

return M
