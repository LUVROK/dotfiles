{ pkgs, pkgs-stable, ... }:


{
  environment.systemPackages = with pkgs; [
    # --- dependebs ---
    glibc
    glib
    gcc
    cmake
    buildPackages.gnumake
    gamescope

    # --- xorg ---
    libxcvt
    xkb-switch
    xdotool
    xorg.xsetroot
    xorg.xcursorthemes
    xsettingsd
    xclip
    xcolor
    xwinwrap
    xorg.xinit
    xdg-desktop-portal
    dmenu
    j4-dmenu-desktop

    # --- basic utilities ---
    bash
    lsof
    coreutils
    wget
    curl
    nix-prefetch
    nix-prefetch-git
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
    ripgrep
    fd
    ethtool
    dnsmasq
    tcpdump
    procps

    # --- development tools ---
    nodejs
    yarn
    python315

    # --- networking ---
    openssl
    iptables
    networkmanager
    # xray
    shadowsocks-rust
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
    wasabiwallet
    syncthing
    spotify
    libreoffice
    blueman
    chromium
    librewolf
    veracrypt
    nautilus
    monero-gui
    koreader

    # --- music ---
    gtk3

    # --- talking ---
    discord # some trouble in nixpkgs
    element-desktop
    session-desktop
    element-call
    irssi

    # --- games ---
    prismlauncher

    # --- hardware ---
    dualsensectl # CLI interface for controlling Sony Dualsense controllers
    # openrgb-with-all-plugins

    # --- android ---
    android-tools
    adbfs-rootless
    jmtpfs

    # --- live usb ---
    woeusb
    unetbootin

    # --- testing system ---
    vrrtest
    stress-ng
    lksctp-tools
    evtest
    xorg.xev

    # --- go ---
    go
    gopls
    delve
    golangci-lint
    goimports-reviser
    gotools

    # --- temporary ---
    pavucontrol
  ];
}
