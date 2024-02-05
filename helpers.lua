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

_H.cropSurface = function(ratio, surf)
	local old_w, old_h = gears.surface.get_size(surf)
	local old_ratio    = old_w / old_h
	if old_ratio == ratio then return surf end

	local new_w = old_w
	local new_h = old_h
	local offset_w, offset_h = 0, 0
	-- Quick mafs
	if (old_ratio < ratio) then
		new_h    = math.ceil(old_w * (1 / ratio))
		offset_h = math.ceil((old_h - new_h) / 2)
	else
		new_w    = math.ceil(old_h * ratio)
		offset_w = math.ceil((old_w - new_w) / 2)
	end

	local out_surf = cairo.ImageSurface(cairo.Format.ARGB32, new_w, new_h)
	local cr       = cairo.Context(out_surf)
	cr:set_source_surface(surf, -offset_w, -offset_h)
	cr.operator = cairo.Operator.SOURCE
	cr:paint()

	return out_surf
end

return _H
