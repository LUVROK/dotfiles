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
    ./system
    ./nixos
    ./overlays
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    displayManager.defaultSession = "none+dwm";
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
    ];
  };

  users.users.root.shell = pkgs.zsh;
  users.users.dash.shell = pkgs.zsh;

  security.polkit.enable = true;
  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [
    # --- dependebs ---
    glibc
    glib
    gcc
    cmake
    buildPackages.gnumake

    # --- basic utilities ---
    bash
    lsof
    coreutils
    wget
    curl
    nix-prefetch-git
    nix-index
    man
    unzip
    unrar
    p7zip
    zip 
    htop
    (btop.override {cudaSupport = true;})
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

    # --- development tools ---
    nodejs
    yarn

    # --- networking ---
    openssl
    iptables
    iwd

    # --- system tools ---
    libnotify
    jq

    # --- multimedia ---
    ffmpeg
    gpa
    # profanity # not use by now
    ncdu

    # --- apps ---
    monero-gui
    vscodium
    chromium
    mpv
    qbittorrent
    telegram-desktop
    obsidian
    mullvad-vpn
    wasabiwallet
    syncthing
    spotify
    libreoffice
    blueman

    # --- talking ---
    discord
    element-desktop
    simplex-chat-desktop
    # jitsi-meet-electron # not use by now
    psi-plus
    irssi

    # --- games ---
    prismlauncher

    # --- bash ---
    nvidia-offload
  ];

  system.stateVersion = "24.11";
}
