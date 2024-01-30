-- Load luarocks if installed
pcall(require, 'luarocks.loader')

-- Load theme
require('beautiful').init(require('theme'))

-- Load key and mouse bindings
require('bindings')

-- Load rules
require('rules')

-- Load signals
require('signals')

-- Load autoexecs
require('config.auto')

-- 🗑 Garbage Collector Settings
require('gears').timer {
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    collectgarbage "collect"
  end,
}

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
