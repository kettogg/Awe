local awful                    = require('awful')
local hotkeys_popup            = require('awful.hotkeys_popup')
local beautiful                = require('beautiful')
local wibox                    = require('wibox')
local gears                    = require('gears')
local helpers                  = require('helpers')
local gfs                      = gears.filesystem
local feather                  = gfs.get_configuration_dir() .. 'theme/assets/feather/'
local dpi                      = beautiful.xresources.apply_dpi
local apps                     = require('config.apps')

-- 'Sections'.
local _S                       = {}

_S.awesome                     = {
	{ 'Keybinds',    function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ 'Manpage',     apps.manual_cmd },
	{ 'Edit config', apps.editor_cmd .. ' ' .. awesome.conffile },
	{ 'Reload',      awesome.restart },
	{ 'Quit',        function() awesome.quit() end }
}

_S.power                       = {
	{ 'Log off',  function() awesome.quit() end },
	{ 'Suspend',  function() os.execute('suspend') end },
	{ 'Reboot',   function() os.execute('reboot') end },
	{ 'Shutdown', function() os.execute('poweroff') end }
}

-- The widgets to return.
local _M                       = {}

_M.mainmenu                    = awful.menu {
	items = {
		{ 'Terminal', apps.terminal },
		{ 'Editor',   apps.editor },
		{ 'Browser',  apps.browser },
		{ 'Awesome',  _S.awesome, beautiful.awesome_icon },
		{ 'Power',    _S.power }
	},
}

-- Rounded corners on the menu...
_M.mainmenu.wibox.bg           = beautiful.transparent
_M.mainmenu.wibox.shape        = helpers.rrect(0)
_M.mainmenu.wibox.border_width = dpi(1)
_M.mainmenu.wibox.border_color = beautiful.mid_normal
_M.mainmenu.wibox:set_widget(wibox.widget {
	widget = wibox.container.background,
	shape  = helpers.rrect(0),
	bg     = beautiful.bg_normal,
	{
		widget  = wibox.container.margin,
		margins = dpi(12),
		{
			widget = wibox.container.background,
			shape  = helpers.rrect(0),
			_M.mainmenu.wibox.widget
		}
	}
})

-- ...and its submenus.
awful.menu.original_new = awful.menu.new
function awful.menu.new(...)
	local sub              = awful.menu.original_new(...)
	sub.wibox.bg           = beautiful.transparent
	sub.wibox.shape        = helpers.rrect(0)
	sub.wibox.border_width = dpi(1)
	sub.wibox.border_color = beautiful.mid_normal
	sub.wibox:set_widget(wibox.widget {
		widget = wibox.container.background,
		shape  = helpers.rrect(0),
		bg     = beautiful.bg_normal,
		{
			widget  = wibox.container.margin,
			margins = dpi(12),
			{
				widget = wibox.container.background,
				shape  = helpers.rrect(0),
				sub.wibox.widget
			}
		}
	})
	return sub
end

return _M
