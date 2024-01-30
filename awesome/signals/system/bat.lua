local awful          = require('awful')
local gears          = require('gears')
local gfs            = gears.filesystem

-- Battery Fetching and Signal Emitting
---------------------------------------
-- Battery information script
local battery_script =
"bash -c 'echo $(cat /sys/class/power_supply/BAT1/capacity) echo $(cat /sys/class/power_supply/BAT1/status)'"

local function battery_emit()
  awful.spawn.easy_async_with_shell(
    battery_script, function(stdout)
      -- The battery level and status are saved as a string. Then the level
      -- is stored separately as a string, then converted to int. The status
      -- is stored as a bool, and also as an int for registering changes in
      -- battery status.
      local level     = string.match(stdout:match('(%d+)'), '(%d+)')
      -- print(level)
      local level_int = tonumber(level)
      -- print(level_int)               -- integer
      local power     = not stdout:match('Discharging') -- boolean
      awesome.emit_signal('signal::bat', level_int, power)
    end)
end

-- Refreshing
-------------
gears.timer {
  timeout   = 20,
  call_now  = true,
  autostart = true,
  callback  = function()
    battery_emit()
  end
}
