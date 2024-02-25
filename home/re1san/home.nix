{ config, pkgs, ... }:

{
  home.username = "re1san";
  home.homeDirectory = "/home/re1san";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
