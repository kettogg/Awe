{ config, colors, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = {
      la = "exa -l";
      ls = "ls --color=auto";
      v = "nvim";
      nf = "neofetch";
      dev = "cd ~/Dev";
      lia = "cd ~/Dev/Lia";
      muse  = "cd ~/Dev/MuseScore";
      freem = "sudo sh -c 'echo 1 >  /proc/sys/vm/drop_caches'";
      param = "ssh-keygen -R paramganga.iitr.ac.in && ssh -p 4422 dhruv_s.iitr@paramganga.iitr.ac.in";
      hmswitch = "home-manager switch --flake /etc/nixos/#ketto";
      nixswitch = "sudo nixos-rebuild switch --flake /etc/nixos/#fuyumi"; 
      nix-pkgs = "nix --extra-experimental-features 'nix-command flakes' search nixpkgs";
    };
    history = {
      expireDuplicatesFirst = true;
      save = 1024;
    };
    initExtra = ''
      # This let's me execute arbitrary binaries downloaded through channels such as mason/pip from a venv.
      # See https://www.reddit.com/r/NixOS/comments/13uc87h/masonnvim_broke_on_nixos
      # To use this we need to enable https://github.com/Mic92/nix-ld
      export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
      
      # export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH # This one is risky to add here as there might be a possibility that a nix-package might access the loader through nix-ld instead of the system one.
      # Better option is to add this in a shell.nix setup for a venv.

      export PATH=${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/share/nvim/mason/bin:$PATH
      
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };

  # Starship
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$nix_shell$directory$git_branch$git_status$cmd_duration$python\n[  󰅂](fg:cyan) ";
      command_timeout = 4000;

      directory = {
        format = "[$path](bg:none fg:blue) ";
      };

      git_status = {
        conflicted = "=";
        ahead = "⇡ $count";
        behind = "⇣ $count";
        diverged = "↑ $ahead_count ⇣ $behind_count ";
        up_to_date = " ";
        untracked = "?$count";
        stashed = "󰏖 ";
        modified = "!$count";
        staged = "+$count";
        renamed = "» $count";
        deleted = " $count";
        style = "bright-red bold";
      };

      git_branch = {
        symbol = "󰘬 ";
        format = "via [$symbol$branch(:$remote_branch)]($style) ";
        style = "red";
      };
      
      nix_shell = {
        disabled = false;
        format = "[\\($name $state\\)]($style) ";
        style = "purple";
      };

      python = {
        format = "[$virtualenv]($style) ";
        style = "purple";
      };
    };
  };
}
