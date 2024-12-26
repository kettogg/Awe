{ config, pkgs, ... }:

let
  callPackage = pkgs.callPackage;
  colors = import ../shared/colors/oxocarbon.nix {};
in
{
  nixpkgs = { 
    overlays = [
      ( import ../../overlays/default.nix )
    ];
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.home-manager.enable = true;

  home = { 
    username = "ketto";
    homeDirectory = "/home/ketto";
    stateVersion = "23.11";
    
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  
  # Cursor
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Fuyu";
    package = callPackage ../../pkgs/cursors/fuyu.nix {};
    size = 32;
  };

  # Gtk
  gtk = {
    enable = true;
    iconTheme.package = callPackage ../../pkgs/icons/zafiro.nix {};
    iconTheme.name = "Zafiro-Icons-Dark-Blue";
    theme.package = pkgs.materia-theme;
    theme.name = "Materia-dark";
  };

  # Qt
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk2";
  };

  home = { 
    # Clone configurations
    activation = {
      installConfig = ''
        if [ ! -d "${config.home.homeDirectory}/.config/awesome" ]; then
          ${pkgs.git}/bin/git clone --depth 1 --branch rei --recurse-submodules https://github.com/ketto/Awe.git ${config.home.homeDirectory}/.config/awesome 
        fi
        if [ ! -d "${config.home.homeDirectory}/.config/nvim" ]; then
          ${pkgs.git}/bin/git clone --depth 1 https://github.com/ketto/Nv.git ${config.home.homeDirectory}/.config/nvim
        fi
      '';
    };

    # Packages
    packages = with pkgs; [
      alacritty
      cava
      discord
      eza
      firefox
      google-chrome
      imagemagick
      materia-theme
      playerctl
      redshift
      vscode
      (import ../../pkgs/misc/bloks.nix { inherit pkgs; })
    ];
  };

  home.file.".xinitrc".text = ''
    #!/usr/bin/env bash
    xrdb -merge ~/.Xresources &
    exec awesome  
  '';

  home.file.".config/discord/settings.json".text = ''
  {
    "SKIP_HOST_UPDATE": true
  }
  '';

  # Import configurations
  imports = [
    (import ./cfg/term/alacritty { inherit colors; })
    (import ./cfg/lock { inherit colors; })
    (import ./cfg/shell/zsh { inherit config colors pkgs; })
    (import ../shared/bin { inherit config colors; })
  ];

} 
