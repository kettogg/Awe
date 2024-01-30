local gears                 = require('gears')
local wibox                 = require('wibox')
local awful                 = require('awful')
local dpi                   = require('beautiful').xresources.apply_dpi
local beautiful             = require('beautiful')
local gfs                   = gears.filesystem
local asset_path            = gfs.get_configuration_dir() .. 'theme/assets/battery/'
local helpers               = require('helpers')

-- Cute battery face indicator
------------------
-- Stolen from Elena

return function()
  local stroke_normal         = beautiful.bg_normal
  local stroke                = beautiful.bg_light
  local happy_color           = beautiful.cyan
  local sad_color             = beautiful.red
  local ok_color              = beautiful.yellow
  -- Not great not terrible
  local ok_threshold          = 40
  
  -- Low percentage
  local battery_threshold_low = 20
  
  
  local battery_bar = wibox.widget {
    max_value = 100,
    forced_height = dpi(36),
    forced_width = dpi(90),
    bar_shape = gears.shape.rectangle,
    color = happy_color,
    background_color = happy_color .. '55',
    widget = wibox.widget.progressbar,
  }
  
  local battery_bar_container = wibox.widget {
    battery_bar,
    direction = 'north',   --Progress
    widget = wibox.container.rotate
  }
  
  local charging_icon = wibox.widget {
    {
      id = "image",
      image = gears.color.recolor_image(asset_path .. "chargin.svg", beautiful.bg_normal),
      widget = wibox.widget.imagebox,
      forced_height = dpi(10),
      forced_width = dpi(10)
    },
    id = "icon_layout",
    widget = wibox.container.place
  }
  
  local eye_size = dpi(5)
  local mouth_size = dpi(10)
  
  local mouth_shape = function()
    return function(cr, width, height)
      gears.shape.pie(cr, width, height, 0, math.pi)
    end
  end
  
  local mouth_widget = wibox.widget {
    forced_width = mouth_size,
    forced_height = mouth_size,
    shape = mouth_shape(),
    bg = stroke,
    widget = wibox.container.background()
  }
  
  local frown = wibox.widget {
    {
      mouth_widget,
      direction = 'south',
      widget = wibox.container.rotate()
    },
    top = dpi(8),
    widget = wibox.container.margin()
  }
  
  local smile = wibox.widget {
    mouth_widget,
    direction = 'north',
    widget = wibox.container.rotate()
  }
  
  local ok = wibox.widget {
    {
      bg = stroke,
      shape = function(c, w, h)
        gears.shape.rounded_rect(c, w, h, dpi(2))
      end,
      widget = wibox.container.background
    },
    top = dpi(5),
    bottom = dpi(1),
    widget = wibox.container.margin()
  }
  
  local mouth = wibox.widget {
    frown,
    ok,
    smile,
    top_only = true,
    widget = wibox.layout.stack()
  }
  
  local eye = wibox.widget {
    forced_width = eye_size,
    forced_height = eye_size,
    shape = gears.shape.circle,
    bg = stroke,
    widget = wibox.container.background()
  }
  
  -- 2 eyes 1 semicircle (smile or frown)
  local face = wibox.widget {
    eye,
    mouth,
    eye,
    spacing = dpi(4),
    layout = wibox.layout.fixed.horizontal
  }
  
  local battery_status = function(color)
    if battery_bar.value <= battery_threshold_low then
      color = sad_color
      mouth:set(1, frown)
    elseif battery_bar.value <= ok_threshold then
      color = ok_color
      mouth:set(1, ok)
    else
      color = happy_color
      mouth:set(1, smile)
    end
  
    battery_bar.color = color
    battery_bar.background_color = color .. '44'
  end
  
  awesome.connect_signal('signal::battery', function(level, state, _, _, _)
    -- Update bar
    battery_bar.value = level
  
    local color
    if state ~= 2 then
      charging_icon.visible = true
      battery_status(color)
    else
      charging_icon.visible = false
      battery_status(color)
    end
  
    awful.tooltip({
      objects = { battery_bar },
      text    = string.format("Batery: %d%%", battery_bar.value),
      mode    = 'outside',
      margins = dpi(8)
    })
  end)

  -- Final widget

  local bat_complete_icon = wibox.widget {
    {
        battery_bar_container,
        shape = function(c, w, h)
          gears.shape.rounded_rect(c, w, h, 0)
        end,
        border_color = stroke,
        border_width = dpi(0),
        widget = wibox.container.background
      },
      {
        {
          nil,
          charging_icon,
          nil,
          expand = 'none',
          layout = wibox.layout.align.horizontal
        },
        left = dpi(45),
        bottom = dpi(10),
        widget = wibox.container.margin,
      },
      {
        nil,
        {
          nil,
          face,
          layout = wibox.layout.align.vertical,
          expand = 'none'
        },
        layout = wibox.layout.align.horizontal,
        expand = 'none'
      },
      top_only = false,
      layout = wibox.layout.stack
  }

  local final_widget = wibox.widget {
    {
        bat_complete_icon,
        {
            {
                font = beautiful.font_nerd .. " 12",
                markup = helpers.colorizeText("25%", beautiful.fg_normal),
                valign = "center",
                id = "batvalue",
                widget = wibox.widget.textbox,
            },
            left = dpi(5),
            right = dpi(5),
            widget = wibox.container.margin,
        },
        layout = wibox.layout.align.horizontal,
        spacing = 4,
    },
    bg     = beautiful.bg_light,
    widget = wibox.container.background,
    shape = function(c, w, h)
        gears.shape.rounded_rect(c, w, h, 2)
    end,
  }

  awesome.connect_signal("signal::bat", function(value)
    -- local b = final_widget:get_children_by_id("prog")[1]
    local v = final_widget:get_children_by_id("batvalue")[1]
    -- print(value)
    v.markup = helpers.colorizeText(value .. "%", beautiful.fg_normal)
    -- b.value = value
    -- if value > 80 then
    --   b.color = beautiful.green
    -- elseif value > 20 then
    --   b.color = beautiful.blue
    -- else
    --   b.color = beautiful.red
    -- end
  end)
  
  local old_background = battery_bar.color
  
  final_widget:connect_signal('mouse::enter', function()
    battery_bar.color = old_background .. 30
  end)
  
  final_widget:connect_signal('mouse::leave', function()
    battery_bar.color = old_background
  end)
  
  return final_widget
end

