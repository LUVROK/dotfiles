{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
    ./nvidia.nix
    ./env.nix
    ./touchpad.nix
    ../config/syncthing.nix
    ../config/fonts.nix
    ../config/mysql.nix
    ../config/pipewire.nix
    ../config/tor.nix
    ../config/python.nix
    ../config/qmk.nix
    ./virtualisation.nix
    ./dwm.nix
  ];
  
  programs.xwayland.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  services.thermald.enable = lib.mkDefault true;

  # Set your time zone.
  time.timeZone = "Asia/Yakutsk";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  services = {
    mullvad-vpn.enable = true;
    printing.enable = true;
    dbus.enable = true;
    displayManager.defaultSession = "none+dwm";

    xserver = {
      xkb = {
        variant = "";
        options = "";
        layout = "us,ru";
      };

      displayManager.gdm.enable = false;
      displayManager.lightdm = {
        enable = true;
        background = ./Cole_Thomas_The_Course_of_Empire_Destruction_1836.jpg;

        greeters.slick = {
          enable = true;
          theme = {
            name = "vimix-dark-ruby";
            package = pkgs.vimix-gtk-themes.override {
              themeVariants = ["ruby"];
              colorVariants = ["dark"];
              tweaks = ["flat" "grey"];
            };
          };
          iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
          };
          extraConfig = ''
            show-a11y=false
            clock-format=%H:%M:%S
          '';
        };
      };
    };
  };

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };

  sound.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "deno"
      ];
    };
  };

  users.groups.libvirt = {};
  users.groups.vboxsf = {};
  users.groups.plugdev = {};
  users.groups.storage = {};

  users.users.dash = {
    isNormalUser = true;
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "kvm" 
      "libvirt" 
      "libvirtd"
      "vboxusers" 
      "vboxsf" 
      "video"  
      "audio"
      "plugdev"
      "storage"
      "input"
    ];
    shell = pkgs.zsh;
  };

  users.users.root = {
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  programs.chromium = {
    enable = true;
    extraOpts = {};
  };

  security.polkit.enable = true;
  programs.udevil.enable = true;  

  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [
    # icons
    adwaita-icon-theme
    gtk-engine-murrine
    gtk3
    vimix-gtk-themes

    # proxy
    tor 
    torsocks

    # dependebs
    glibc
    glib

    # Basic utilities
    coreutils
    wget
    curl
    gitAndTools.gitFull
    gh
    man
    unzip
    unrar
    p7zip
    fzf
    ripgrep
    fd
    btop
    libinput
    openvpn
    killall
    pulseaudio
    alsaUtils
    pavucontrol
    pamixer
    pulseaudio-ctl
    libreoffice
    dig  
    nmap  
    inetutils
    brightnessctl
    usbutils
    udevil
    bc
    sqlite
    powertop
    vnstat

    # pass
    pass
    pinentry

    # Development tools
    nodejs
    nodePackages.bower
    nodePackages.gulp
    yarn    

    # Networking
    openssl

    # System tools
    gparted
    kdiff3
    lshw
    mlocate
    electron
    mesa-demos
    libnotify
    wirelesstools
    jq
    zip
    st

    # X11
    xorg.xrandr
    xorg.xinit
    xorg.xsetroot
    xorg.xcursorthemes
    xsettingsd
    xclip
    xorg.xev
    xorg.xorgserver
    xorg.xf86inputlibinput
    xorg.xf86videointel
    xorg.xwininfo
    xorg.libX11
    xorg.libX11.dev
    buildPackages.gnumake
    xkb-switch
    xwinwrap
    xdotool
    xcolor
    xorg.xmodmap

    # Multimedia
    ffmpeg

    # shell
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    zsh-autocomplete
    zsh-syntax-highlighting
    zsh-autosuggestions
    syncthing
    gpa
    tor
    vopono
    htop
    trash-cli
    gcc

    # apps
    monero-gui
    wasabiwallet
    vscodium
    element-desktop
    firefox
    chromium    
    mpv
    discord
    qbittorrent
    telegram-desktop
    obsidian
    steam
    mullvad-vpn
    veracrypt
    sublime
    appimagekit
    profanity
    figma-linux
    unetbootin
    psi-plus
    bisq-desktop
    prismlauncher
    brave
    qpwgraph

    pciutils
    ncdu
    wireguard-tools

    php

    haskellPackages.xmobar
    haskellPackages.pandoc
    
    qt5.qtbase

    lightdm-gtk-greeter
    blueman

    go
    cmake

    evtest
  ];

  services.resolved.enable = true;
  system.stateVersion = "24.05";
}
