{ config, colors, ... }:

{
  home.file = {
    ".local/bin/cols" = {
      executable = true;
      text = import ./cols {};
    };
    ".local/bin/lock" = {
      executable = true;
      text = import ./lock { inherit config colors; };
    };
    ".local/bin/nvidia-offload" = {
      executable = true;
      text = import ./nvidia-offload {};
    };
  };
}
