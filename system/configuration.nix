{ config, lib, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
    ./env.nix
    ./dwm.nix
    ./nvidia.nix
    ./hardware-configuration.nix
    ../config/touchpad.nix
    ../config/syncthing.nix
    ../config/fonts.nix
    ../config/pipewire.nix
    ../config/tor.nix
    ../config/qmk.nix
    ../config/st/st.nix
    ../config/virtualisation.nix
    ../config/wireless.nix
    # ../config/unstoppableSwap.nix
    # ./config/stylix.nix
    ../config/display-managers/displaymanager.nix
  ];

  hardware.enableAllFirmware = true;
  
  programs.xwayland.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
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
    displayManager.ly.enable = false;

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
  # services.gvfs.enable = true;
  # services.devmon.enable = true;
  # services.udisks2.enable = true;
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
    gh # github cli
    man
    unzip
    unrar
    p7zip # 7z
    (btop.override {cudaSupport = true;})
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
    powertop
    vnstat
    exfat

    # Development tools
    nodejs
    nodePackages.bower
    nodePackages.gulp
    yarn    

    # Networking
    openssl
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

    # X11
    xorg.xrandr
    xorg.xinit
    xorg.xsetroot
    xorg.xcursorthemes
    xorg.xev
    xorg.xorgserver
    xorg.xf86inputlibinput
    xorg.xf86videointel
    xorg.xwininfo
    xorg.libX11
    xorg.libX11.dev
    xorg.xmodmap
    xsettingsd
    xclip
    buildPackages.gnumake
    xkb-switch
    xwinwrap
    xdotool
    xcolor

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
    tor
    vopono
    htop
    trash-cli
    gcc

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
    sublime
    wasabiwallet
    syncthing

    # appimage
    appimagekit
    appimage-run

    profanity
    unetbootin
    psi-plus
    bisq-desktop
    prismlauncher
    brave
    qpwgraph
    spotify

    pciutils
    ncdu
    wireguard-tools

    haskellPackages.xmobar
    haskellPackages.pandoc
    
    qt5.qtbase

    blueman

    go
    cmake

    evtest
  ];

  services.resolved.enable = true;
  system.stateVersion = "24.05";
}
