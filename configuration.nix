{ config, lib, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
    ./system/env.nix
    ./system/dwm.nix
    ./system/nvidia.nix
    ./system/hardware-configuration.nix
    ./nixos
  ];

  hardware.enableAllFirmware = true;
  programs.xwayland.enable = true;

  services.thermald.enable = lib.mkDefault true;
  time.timeZone = "Europe/Ulyanovsk";

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
    };
  };

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      # theme = "robbyrussell";
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "deno"
      ];
    };
  };
  
  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    # nftables.enable = true;
    # nameservers = [ "127.0.0.1" ];
  };

  users.groups.libvirt = {};
  users.groups.vboxsf = {};
  users.groups.plugdev = {};
  users.groups.storage = {};

  users.users.dash = {
    isNormalUser = true;
    extraGroups = [ 
      "networkmanager" 
      "network" 
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
      "dialout" # for microcontrollers
      # "openrazer"
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
    orjail
    vopono
    proxychains
    firejail
    openvpn
    wireguard-tools

    # dependebs
    glibc
    glib
    gcc
    go
    cmake
    qt5.qtbase
    haskellPackages.xmobar
    haskellPackages.pandoc

    # Basic utilities
    bash
    lsof
    sshfs
    coreutils
    wget
    curl
    gitAndTools.gitFull
    nix-prefetch-git
    nix-output-monitor
    gh # github cli
    man
    unzip
    unrar
    p7zip # 7z
    (btop.override {cudaSupport = true;})
    libinput
    killall
    libreoffice
    dig  
    nmap  
    inetutils
    brightnessctl
    usbutils
    udevil
    bc
    powertop
    vnstat
    exfat
    testdisk
    feh
    pciutils
    qpwgraph
    e2fsprogs
    acpi
    util-linux
    calcurse
    lock
    comma
    nix-index

    # Development tools
    nodejs
    nodePackages.bower
    nodePackages.gulp
    yarn    

    # Networking
    openssl
    iptables
    iwd

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
    arduino
    blueman

    # X11
    xorg.xrandr
    xorg.xinit
    xorg.xsetroot
    xorg.xcursorthemes
    xorg.xev
    xorg.xorgserver
    xorg.xf86inputlibinput
    # xorg.xf86videointel # not support anymore
    xorg.xwininfo
    xorg.libX11
    xorg.libX11.dev
    xorg.xmodmap
    xorg.xdpyinfo
    xorg.libXinerama
    xdg-desktop-portal
    xsettingsd
    xclip
    buildPackages.gnumake
    xkb-switch
    xwinwrap
    wmctrl
    xdotool
    xcolor
    tmux
    evtest

    # Multimedia
    ffmpeg

    # shell
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    zsh-autocomplete
    zsh-syntax-highlighting
    zsh-autosuggestions
    gpa
    htop
    trash-cli
    profanity
    unetbootin
    ncdu

    # apps
    monero-gui
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
    wasabiwallet
    syncthing
    spotify
    psi-plus
    # bisq-desktop # not support anymore
    prismlauncher
    caffeine-ng
    irssi
    myxer

    # appimage
    # appimagekit
    # appimage-run
  ];

  system.stateVersion = "24.05";
}
