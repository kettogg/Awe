-- This is used later as the default terminal and editor to run.
local apps      = {}
apps.terminal   = 'alacritty'
apps.editor     = os.getenv('EDITOR') or 'nvim'
apps.editor_cmd = apps.terminal .. ' -e ' .. apps.editor
apps.browser    = 'google-chrome-beta'

-- Set the terminal for the menubar.
require('menubar').utils.terminal = apps.terminal

return apps
