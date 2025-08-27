{ config, lib, pkgs, pkgs-stable, inputs, username, ... }:

{
  imports = [
    ../nixos
    ../overlays
  ];

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
    mullvad-vpn.enable = true;
    dbus.enable = true;
    dbus.implementation = "broker";
    devmon.enable = true;
    displayManager.defaultSession = "none+dwm";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  security.sudo.extraConfig = ''
    Defaults lecture = never
    Defaults timestamp_type=pid
    Defaults timestamp_timeout=45
  '';
  
  programs.nix-ld.enable = true;
  
  services.journald.console = "/dev/tty4";

  users.groups.libvirt = {};
  users.groups.vboxsf = {};
  users.groups.plugdev = {};
  users.groups.storage = {};

  users.users.${username} = {
    shell = pkgs.zsh;
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
      "audio"
      "openrazer" 
      "plugdev" # ?
      "storage"
      "input"
      "video"
      "dialout" # for microcontrollers
    ];
  };

  users.users.root.shell = pkgs.zsh;

  security.polkit.enable = true;
  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [
    # --- dependebs ---
    glibc
    glib
    gcc
    cmake
    buildPackages.gnumake
    gamescope

    # --- basic utilities ---
    bash
    lsof
    coreutils
    wget
    curl
    nix-prefetch-git
    nix-index
    home-manager
    man
    unzip
    unrar
    p7zip
    zip 
    htop
    (btop.override {rocmSupport = true;})
    killall
    dig
    nmap
    inetutils # telnet, ftp, hostname, etc
    brightnessctl
    usbutils
    bc
    powertop
    lshw
    mesa-demos
    vnstat
    testdisk
    feh
    pciutils
    qpwgraph
    e2fsprogs
    acpi
    util-linux
    calcurse # calendar in terminal
    woeusb
    unetbootin
    pacman
    efibootmgr
    grub2
    nautilus
    parted
    nvme-cli

    # --- development tools ---
    nodejs
    yarn

    # --- networking ---
    openssl
    iptables
    networkmanager
    # iwd
    # iw

    # --- system tools ---
    libnotify
    jq

    # --- multimedia ---
    ffmpeg

    # --- apps ---
    vscodium
    mpv
    qbittorrent
    telegram-desktop
    obsidian
    mullvad-vpn
    shadowsocks-libev
    wasabiwallet
    syncthing
    spotify
    libreoffice
    blueman
    chromium
    
    # --- music ---
    gtk3

    # --- talking ---
    discord
    element-desktop
    element-call
    psi-plus
    irssi

    # --- games ---
    prismlauncher

    # Adb sideload
    android-tools

    # Mount android phones
    adbfs-rootless
    jmtpfs
    glib

    # Work with usb devices
    usbutils

    openrgb-with-all-plugins

    # live usb
    woeusb

    # testing system
    vrrtest

    xray
    nekoray
  ];

  system.stateVersion = "24.11";
}
