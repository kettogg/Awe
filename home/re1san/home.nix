{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home = { 
    username = "re1san";
    homeDirectory = "/home/re1san";
    stateVersion = "23.11";
    
    sessionVariables = {
      EDITOR = "nvim";
    };
   
    # Packages
    packages = with pkgs; [
      alacritty
      cava
      discord
      #dconf # For gtk (set in configuration.nix)
      eza
      firefox
      google-chrome
      maim # Screenshot
      playerctl
      redshift
    ];
  };

  nixpkgs.config = {
    permittedInsecurePackages = [ "electron-25.9.0" ];
    allowUnfree = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
  };

  # Starship
  programs.starship.enable = true;

  # X configuration
  home.file.".Xresources".text = ''
    Xft.dpi: 144
    Xcursor.theme: Tsuki_Snow
    Xcursor: 32
  '';

  home.file.".xinitrc".text = ''
    #!/usr/bin/env bash
    xrdb -merge ~/.Xresources &
    exec awesome  
  '';

  # Discord
  home.file.".config/discord/settings.json".text = ''
  {
    "SKIP_HOST_UPDATE": true
  }
  '';

  # Gtk
  gtk = {
    enable = true;
    iconTheme.name = "Zafiro-Icons-Dark-Blue";
    theme.name = "Materia-Dark";
    cursorTheme.name = "Tsuki_Snow";
  };
} 
