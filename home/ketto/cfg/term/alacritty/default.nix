{ colors, ... }:

with colors; {
  home.file.".config/alacritty/alacritty.toml".text = ''
  [font]
  size = 10.0
  offset = { x = -1, y = 0 }

  [font.bold]
  family = 'Iosevka NF'
  style = 'Bold'

  [font.bold_italic]
  family = 'Iosevka NF'
  style = 'Bold Italic'

  [font.italic]
  family = 'Iosevka NF'
  style = 'Italic'

  [font.normal]
  family = 'Iosevka NF'
  style = 'Regular'

  [cursor]
  style = { shape = 'Block', blinking = 'Off' } 

  [window]
  dimensions = { columns = 96, lines = 20 }
  padding = { x = 16, y = 16 }

  [keyboard]
  bindings = [
   { key = 'Return', mods = 'Control|Shift', action = 'SpawnNewInstance' }
  ] 
  
  [colors.primary]
  background = '#${background}'
  foreground = '#${foreground}'

  # Normal colors
  [colors.normal]
  black   = '#${color0}'
  red     = '#${color1}'
  green   = '#${color2}'
  yellow  = '#${color3}'
  blue    = '#${color4}'
  magenta = '#${color5}'
  cyan    = '#${color6}'
  white   = '#${color7}'

  # Bright colors
  [colors.bright]
  black   = '#${color8}'
  red     = '#${color9}'
  green   = '#${color10}'
  yellow  = '#${color11}'
  blue    = '#${color12}'
  magenta = '#${color13}'
  cyan    = '#${color14}'
  white   = '#${color15}'
  '';
}
