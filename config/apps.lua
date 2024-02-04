-- This is used later as the default terminal and editor to run.
local apps      = {}
apps.terminal   = 'kitty'
apps.editor     = os.getenv('EDITOR') or 'nvim'
apps.editor_cmd = apps.terminal .. ' -e ' .. apps.editor
apps.browser    = 'waterfox'

-- Screenshot commands
apps.delay      = 10
apps.fullshot   = 'maim ~/Pictures/Screenshots/$(date "+%d-%m-%Y_%H-%M-%S").png'
apps.selectshot = 'maim -s ~/Pictures/Screenshots/$(date "+%d-%m-%Y_%H-%M-%S").png'
apps.delayshot  = 'maim -d' .. apps.delay .. '~/Pictures/Screenshots/$(date "+%d-%m-%Y_%H-%M-%S").png'
--[[ apps.shadowshot = "maim -st 9999999 | convert - \( +clone -background black -shadow 80x3+5+5 \) +swap -background none -layers merge +repage ~/Pictures/Screenshots/$(date '+%d-%m-%Y_%H-%M-%S').png" ]]
-- Set the terminal for the menubar.
require('menubar').utils.terminal = apps.terminal

return apps
