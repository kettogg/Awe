-- Return a table containing all bar modules, with a name attached
-- to each.
return {
	battery   = require(... .. '.battery'),
	bluetooth = require(... .. '.bluetooth'),
	control   = require(... .. '.control'),
	launcher  = require(... .. '.launcher'),
	layoutbox = require(... .. '.layoutbox'),
	music     = require(... .. '.music'),
	systray   = require(... .. '.systray'),
	taglist   = require(... .. '.taglist'),
	tasklist  = require(... .. '.tasklist'),
	time      = require(... .. '.time'),
	wifi      = require(... .. '.wifi'),
}
