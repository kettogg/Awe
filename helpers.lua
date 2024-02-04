local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local dpi       = beautiful.xresources.apply_dpi
local cairo     = require('lgi').cairo

local _H        = {}

_H.rrect        = function(radius)
	radius = radius or dpi(4)
	return function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, radius)
	end
end

_H.slantrect    = function(delta)
	delta = delta or dpi(4)
	return function(cr, width, height)
		gears.shape.parallelogram(cr, width, height, width - delta)
	end
end

_H.recolorImage = function(image, color)
	return gears.color.recolor_image(image, color)
end

return _H
