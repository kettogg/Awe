{ config, colors, ... }:
''
if [ ! -d "${config.home.homeDirectory}/.cache/betterlockscreen" ]; then
  betterlockscreen -u ${config.home.homeDirectory}/.config/awesome/theme/colorscheme/${colors.name}/wallpaper.png 
fi

sleep 0.2
playerctl pause
betterlockscreen -l dim --show-layout
''
