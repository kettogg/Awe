{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../shared/nvidia    
    ];

  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
      gfxmodeEfi = "1920x1080";
      useOSProber = true;
    };
  };

  # Networking
  networking.hostName = "komari";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Asia/Kolkata";

  # Locale
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
 
  # AwesomeWM
  services.xserver = {
    enable = true;
    dpi = 144;
    displayManager = {
      startx.enable = true;
      sddm = {
        enable = true; # Needed for polkit service to work
        theme = "Sugar-Candy";
        settings = {
          Theme = {
            CursorTheme = "Fuyu";
          };
        };
      }; 
      defaultSession = "none+awesome";
    };

    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome-git;
    };
  };

  # Dbus
  services.dbus.enable = true;

  # Polkit
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Docker
  virtualisation.docker.enable = true;

  # Make gtk happy
  programs.dconf.enable = true;
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Keymaps in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # CUPS to print documents
  services.printing.enable = true;

  # Pipewire for sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    # Use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Touchpad
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      middleEmulation = true;
      naturalScrolling = true;
    };
  };

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = true;
  };

  # Users
  users.users.ketto = {
    isNormalUser = true;
    description = "Rei";
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "audio"
      "video"
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. 
  # To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    betterlockscreen
    brightnessctl
    cmake
    coreutils
    gcc
    git
    glib
    gtk3
    htop
    home-manager
    libsForQt5.qt5.qtgraphicaleffects # Required by SDDM
    libsForQt5.qt5.qtquickcontrols2
    lshw
    maim
    nix-index # For nix-locate
    neofetch
    neovim
    networkmanagerapplet
    nodejs
    pamixer
    pciutils
    polkit_gnome
    python312
    simplescreenrecorder
    unzip
    usbutils
    wget
    xarchiver
    xclip
    xdg-utils
    xdotool
    xorg.libxcb
    xorg.xcompmgr # Compositor
    xorg.xf86inputevdev
    xorg.xf86inputlibinput
    xorg.xf86inputsynaptics
    xorg.xf86videointel
    zip
    (callPackage ../../pkgs/cursors/fuyu.nix {})
    (callPackage ../../pkgs/sddm/sugar-candy.nix {})
  ];

  # Upower
  services.upower.enable = true;

  # Nix-ld
  # See https://github.com/Mic92/Nix-ld
  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   stdenv.cc.cc.lib
  #   zlib # For Numpy
  # ];

  # Thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Fonts
  fonts.packages = with pkgs; [
    ibm-plex
    manrope
    material-design-icons
    material-symbols
    noto-fonts-cjk
    noto-fonts-color-emoji
    rubik
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "IBM Plex Serif" ];
      sansSerif = [ "Manrope" ];
      monospace = [ "Iosevka Nerd Font Mono" ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # Enable Flakes
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
    };
    optimise.automatic = true;
  };
}
