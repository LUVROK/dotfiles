{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
    ./nvidia.nix
    # ./nouveau.nix
    ./touchpad.nix
    ../config/syncthing.nix
    # ../wm/hypr.nix
    ./wayland.nix
  ];

  # Overlays
  nixpkgs.overlays = [
    (import /home/dash/Documents/dotfiles/overlays/appimage-obsidian-overlay.nix)
  ];

  programs.xwayland.enable = true;
  
  environment.variables = {
    EDITOR = "VIM";
  };

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

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    
    xserver = {
      xkb = {
        variant = "";
        options = "";
        layout = "us,ru";
      };

      displayManager.gdm.enable = true;
      windowManager.dwm = { 
        enable = true;
  
        package = pkgs.dwm.overrideAttrs {
           src = ./dwm;
        };
      };
    };
  };

  hardware.pulseaudio.enable = false;

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };

  sound.enable = true;

  security.rtkit.enable = true;
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

  users.users.dash = {
    isNormalUser = true;
    description = "DaSH";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirt" "vboxusers" "video" ];
    shell = pkgs.zsh;
  };

  users.users.root = {
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  programs.chromium = {
    enable = true;
    extraOpts = {};
  };

  environment.systemPackages = with pkgs; [
    # icons
    pkgs.adwaita-icon-theme
    pkgs.gtk-engine-murrine
    pkgs.gtk3

    # Basic utilities
    coreutils
    wget
    curl
    gitAndTools.gitFull
    gh
    man
    unzip
    fzf
    ripgrep
    fd
    btop
    libinput
    openvpn
    killall
    pulseaudio
    pavucontrol
    pamixer
    pulseaudio-ctl
    libreoffice
    dig  
    nmap  
    inetutils

    # Development tools
    nodejs
    yarn    

    # Networking
    openssl

    # System tools
    gparted
    kdiff3
    lshw
    mlocate
    electron
    xorg.xrandr
    xorg.xinit
    xorg.xsetroot
    mesa-demos

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
    pass
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
    # firefox
    prismlauncher
    brave

    # virtualization and nvidia
    qemu_kvm
    qpwgraph
    
    pciutils
    ncdu
    wireguard-tools

    php

    picom

    haskellPackages.xmobar
    haskellPackages.pandoc
  ];

  # VIRTUALBOX
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.virtualbox.guest.enable = true;

  services.resolved.enable = true;
  system.stateVersion = "24.05";
}
