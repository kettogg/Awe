require('awful.autofocus')
local gears = require('gears')
local cairo = require('lgi').cairo
local delayed_call = require("gears.timer").delayed_call
local beautiful = require('beautiful')

-- Focus client on hover.
client.connect_signal('mouse::enter', function(c)
  c:activate { context = 'mouse_enter', raise = false }
end)

client.connect_signal('request::titlebars', function(c)
  -- Don't show titlebars on clients that explictly request not to
  -- have them, like the Steam client or many fullscreen apps, for
  -- example.
  if c.requests_no_titlebar then return end

  require('widgets.titlebar').main(c)
end)

-- Floating windows always on top.
client.connect_signal('property::floating', function(c) c.ontop = c.floating end)

-- Send fullscreen windows to the top.
client.connect_signal('property::fullscreen', function(c) c:raise() end)

-- Add rounder corners
local function applyShape(draw, shape, ...)
  local geo = draw:geometry()
  local shape_args = ...

  local img = cairo.ImageSurface(cairo.Format.A1, geo.width, geo.height)
  local cr = cairo.Context(img)

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0, 0, 0, 1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1, 1, 1, 1)

  shape(cr, geo.width, geo.height, shape_args)

  cr:fill()

  draw.shape_bounding = img._native

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0, 0, 0, 1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1, 1, 1, 1)

  local border = beautiful.base_border_width
  --local titlebar_height = titlebar.is_enabled(draw) and beautiful.titlebar_height or border
  local titlebar_height = border
  gears.shape.transform(shape):translate(
    border, titlebar_height
  )(
        cr,
        geo.width - border * 2,
        geo.height - titlebar_height - border,
        --shape_args
        8
      )

  cr:fill()

  draw.shape_clip = img._native

  img:finish()
end

client.connect_signal("property::geometry", function(c)
  if not c.fullscreen then
    delayed_call(applyShape, c, gears.shape.rounded_rect, 4)
  end
end)
