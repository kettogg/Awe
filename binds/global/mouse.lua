local awful = require('awful')
local ui    = require('ui')

--- Global mouse bindings
awful.mouse.append_global_mousebindings({
	awful.button(nil, 3, function()
		ui.menu.mainmenu:toggle()
	end),
	awful.button(nil, 4, awful.tag.viewnext),
	awful.button(nil, 5, awful.tag.viewprev)
})
