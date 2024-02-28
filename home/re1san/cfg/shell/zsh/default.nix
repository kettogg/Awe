{ config, colors, ... }:
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
      hmswitch = "home-manager switch --flake /etc/nixos/#re1san";
      nixswitch = "sudo nixos-rebuild switch --flake /etc/nixos/#komari"; 
      nix-pkgs = "nix --extra-experimental-features 'nix-command flakes' search nixpkgs";
    };
    history = {
      expireDuplicatesFirst = true;
      save = 1024;
    };
    initExtra = ''
      export PATH=${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/share/nvim/mason/bin:$PATH
      export COLS=${colors.background}\ ${colors.foreground}\ ${colors.color1}\ ${colors.color2}\ ${colors.color3}\ ${colors.color4}\ ${colors.color5}\ ${colors.color6}\ ${colors.color7}\ ${colors.color8}\ ${colors.color9}\ ${colors.color10}\ ${colors.color11}\ ${colors.color12}\ ${colors.color13}\ ${colors.color14}\ ${colors.color15}
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };

  # Starship
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$python\n[  󰅂](fg:cyan) ";
      command_timeout = 4000;

      directory = {
        format = "[$path](bg:none fg:blue) ";
      };

      git_status = {
        conflicted = "=";
        ahead = "⇡ $count";
        behind = "⇣ $count";
        diverged = "↑ $ahead_count ⇣ $behind_count ";
        up_to_date = " ";
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

      python = {
        format = "[$virtualenv]($style) ";
        style = "purple";
      };
    };
  };
}
