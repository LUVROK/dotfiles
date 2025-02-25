{ config, lib, pkgs, inputs, ... }:


let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  imports = [
    ./system/env.nix
    ./system/dwm.nix
    ./system/nvidia.nix
    ./system/hardware-configuration.nix
    ./nixos
    ./overlays
  ];

  hardware.enableAllFirmware = true;
  programs.xwayland.enable = true;

  services.thermald.enable = lib.mkDefault true;
  time.timeZone = "Europe/Moscow";

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
    mozillavpn.enable = true;
    mullvad-vpn.enable = true;
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

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
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
    hostName = "dash";
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
      # "lp" # printer
      "dialout" # for microcontrollers
      # "openrazer"
    ];
    shell = pkgs.zsh;
  };

  users.users.root = {
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    nix-prefetch-git
    nix-output-monitor
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
    woeusb

    # gitAndTools.gitFull
    # gh

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
    gnome-disk-utility
    mediawriter
    gparted

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
    arandr
    keepassxc

    # Multimedia
    ffmpeg
    # jellyfin
    # jellyfin-media-player

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
    sqlite

    # apps
    monero-gui
    vscodium
    element-desktop
    jitsi-meet-electron
    simplex-chat-desktop
    chromium   
    mpv
    discord
    qbittorrent
    telegram-desktop
    obsidian
    mullvad-vpn
    nvidia-offload
    # veracrypt
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

    # NIX
    nix-index
    nix-du
    deploy-rs
  ];

  system.stateVersion = "24.11";
}
