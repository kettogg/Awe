local awful = require('awful')
local gears = require('gears')

-- Bluetooth Fetching and Signal Emitting
-----------------------------------------
local status_old = -1
-- Emit a bluetooth status signal
local function emit_bluetooth_status()
	awful.spawn.easy_async_with_shell(
		"bash -c 'bluetoothctl show | grep -i Powered:'", function(stdout)
			local status    = stdout:match('yes') -- yes/nil
			local status_id = status and 1 or 0 -- 1/0
			if status_id ~= status_old then
				awesome.emit_signal('signal::bluetooth', status)
				status_old = status_id
			end
		end)
end
-- Change bluetooth status
awesome.connect_signal('bluetooth::toggle', function()
	if status_old == 0 then
		awful.spawn('bluetoothctl power on')
	else
		awful.spawn('bluetoothctl power off')
	end
end)

-- Refreshing
-------------
gears.timer {
	timeout   = 10,
	call_now  = true,
	autostart = true,
	callback  = function()
		emit_bluetooth_status()
	end
}
