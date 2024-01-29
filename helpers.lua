-- Useful functions used throughout the configuration
local gears      = require('gears')
local color      = require('modules.color')
local rubato     = require('modules.rubato')
local cairo      = require("lgi").cairo
local beautiful  = require('beautiful')
local dpi        = beautiful.xresources.apply_dpi

local _F         = {}

-- Crylia's app icon fetching function. Scans `/usr/share/icons` for application
-- icons of a set theme and application. Otherwise defaults to Papirus. Requires
-- `/usr/share/icons/Papirus-Dark` to exist to work as intended.
-- https://github.com/Crylia/crylia-theme/blob/main/awesome/src/tools/icon_handler.lua
local icon_cache = {}
-- Define a default icon.
_F.DEFAULT_ICON  = '/home/re1san/.local/share/icons/Reversal-black-dark/apps/scalable/application-default-icon.svg'
function _F.getIcon(theme, client, program_string, class_string)
   client = client or nil
   program_string = program_string or nil
   class_string = class_string or nil

   if theme and (client or program_string or class_string) then
      local clientName
      if client then
         if client.class then
            clientName = string.lower(client.class:gsub(" ", "")) .. ".svg"
         elseif client.name then
            clientName = string.lower(client.name:gsub(" ", "")) .. ".svg"
         else
            if client.icon then
               return client.icon
            else
               return _F.DEFAULT_ICON
            end
         end
      else
         if program_string then
            clientName = program_string .. ".svg"
         else
            clientName = class_string .. ".svg"
         end
      end

      for _, icon in ipairs(icon_cache) do
         if icon:match(clientName) then
            return icon
         end
      end

      local resolutions = {
         -- This is the format Papirus follows.
         "128x128", "96x96", "64x64", "48x48", "42x42", "32x32", "24x24", "16x16",
         -- But some themes actually do this.
         '128', '96', '64', '48', '42', '32', '24', '16'
      }
      for _, res in ipairs(resolutions) do
         local iconDir = "/usr/share/icons/" .. theme .. "/" .. res .. "/apps/"
         local ioStream = io.open(iconDir .. clientName, "r")
         if ioStream ~= nil then
            icon_cache[#icon_cache + 1] = iconDir .. clientName
            return iconDir .. clientName
         else
            clientName = clientName:gsub("^%l", string.upper)
            iconDir = "/usr/share/icons/" .. theme .. "/" .. res .. "/apps/"
            ioStream = io.open(iconDir .. clientName, "r")
            if ioStream ~= nil then
               icon_cache[#icon_cache + 1] = iconDir .. clientName
               return iconDir .. clientName
            elseif not class_string then
               return _F.DEFAULT_ICON
            else
               clientName = class_string .. ".svg"
               iconDir = "/usr/share/icons/" .. theme .. "/" .. res .. "/apps/"
               ioStream = io.open(iconDir .. clientName, "r")
               if ioStream ~= nil then
                  icon_cache[#icon_cache + 1] = iconDir .. clientName
                  return iconDir .. clientName
               else
                  return _F.DEFAULT_ICON
               end
            end
         end
      end
      if client then
         return _F.DEFAULT_ICON
      end
   end
end

-- Blyaticon's image cropping function, uses a cairo surface
-- which it crops to a ratio.
-- https://git.gemia.net/paul.s/homedots/-/blob/main/awesome/helpers.lua#L133
function _F.cropSurface(ratio, surf)
   local old_w, old_h = gears.surface.get_size(surf)
   local old_ratio    = old_w / old_h
   if old_ratio == ratio then return surf end

   local new_w = old_w
   local new_h = old_h
   local offset_w, offset_h = 0, 0
   -- quick mafs
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

-- Applies the blur effect to the titlebar buttons lose focus

function _F.applyTransition(opts)
   opts                   = opts or {}
   local bg               = opts.bg or beautiful.bg_light
   local hbg              = opts.hbg or beautiful.mid_normal
   local element          = opts.element
   local prop             = opts.prop
   local background       = color.color { hex = bg }
   local hover_background = color.color { hex = hbg }
   local transition       = color.transition(background, hover_background, color.transition.RGB)
   local fading           = rubato.timed {
      duration = 0.30,
   }
   fading:subscribe(function(pos)
      element[prop] = transition(pos / 100).hex
   end)
   return {
      on  = function()
         fading.target = 100
      end,
      off = function()
         fading.target = 0
      end
   }
end

-- Finds a value from an array. It is mainly used in the fear widget
function _F.indexOf(array, value)
   for i, v in ipairs(array) do
      if v == value then
         return i
      end
   end
   return nil
end

function _F.rrect(radius)
   radius = radius or dpi(4)
   return function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, radius)
   end
end

function _F.colorizeText(txt, fg)
   if fg == "" then
      fg = "#ffffff"
   end
   return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

-- Idk why I made this when you can just use gc.recolor_image()
function _F.colorizeSvg(filePath, newColor)
   local file = io.open(filePath, "r")
   local svgString = file:read("*a") -- Read the entire file as a string
   file:close()

   local pattern = 'fill="#%x+"'
   local replacement = 'fill="' .. newColor .. '"'
   local newSvgString = svgString:gsub(pattern, replacement)

   local file = io.open(filePath, "w")
   file:write(newSvgString)
   file:close()
end

-- This stands for :get_children_by_id
function _F.gc(widget, id)
   return widget:get_children_by_id(id)[1]
end

function _F.getUserName()
   local name = os.getenv("USER") or os.getenv("USERNAME")
   return name
end

return _F
