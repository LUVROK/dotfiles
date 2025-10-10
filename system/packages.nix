{ pkgs, ... }:

{
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
    nix-prefetch
    nix-prefetch-git
    nix-index
    home-manager
    man
    unzip
    unrar
    p7zip
    zip 
    htop
    iotop
    (btop.override { rocmSupport = true; })
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
    parted
    efibootmgr
    grub2
    pacman

    # --- development tools ---
    nodejs
    yarn

    # --- networking ---
    openssl
    iptables
    networkmanager
    xray
    # iwd
    # iw

    # --- system tools ---
    libnotify
    jq

    # --- multimedia ---
    ffmpeg

    # --- apps ---
    vscodium
    qbittorrent
    telegram-desktop
    obsidian
    shadowsocks-libev
    wasabiwallet
    syncthing
    spotify
    libreoffice
    blueman
    chromium
    librewolf
    veracrypt
    nautilus

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
    gravity-defied-cpp

    # --- hardware ---
    dualsensectl # CLI interface for controlling Sony Dualsense controllers
    openrgb-with-all-plugins

    # --- android ---
    android-tools
    adbfs-rootless
    jmtpfs

    # --- live usb ---
    woeusb
    unetbootin

    # --- testing system ---
    vrrtest

    # --- go ---
    go
    gopls
    delve
    golangci-lint
    goimports-reviser
    gotools
  ];
}
