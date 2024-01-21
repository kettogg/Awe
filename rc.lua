-- awesome_mode: api-level=4:screen=on

-- Run these on startup
local awful = require('awful')
local autorun = true
local autorunApps =
{
  -- "sleep 1 && nitrogen --restore",
  "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
  "redshift",
  -- "nextcloud",
  "picom",
  -- "nm-applet",
  -- "xfce4-power-manager",
  -- "xset s off -dpms",
  -- "input-leap",
}
if autorun then
  for app = 1, #autorunApps do
    awful.util.spawn(autorunApps[app])
  end
end

-- load luarocks if installed
pcall(require, 'luarocks.loader')


-- load theme
require('beautiful').init(require('theme'))


-- load key and mouse bindings
require('bindings')

-- load rules
require('rules')

-- load signals
require('signals')

-- load autoexecs
require('config.auto')

-- 🗑 Garbage Collector Settings
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
