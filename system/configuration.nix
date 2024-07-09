{ config, lib, pkgs, ... }:

{
  imports =
  [
      ./hardware-configuration.nix
      <home-manager/nixos>
      ./nvidia.nix
      ./touchpad.nix
      # <nixos-hardware/common/cpu/intel/tiger-lake>
      # <nixos-hardware/common/pc/laptop>
      # <nixos-hardware/common/gpu/nvidia>
      # ./desktop-packages.nix
      # ./desktops/i3.nix
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
      enable = true;

      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      # displayManager.lightdm.enable = true;
      # displayManager.gdm.wayland = false;

      xkb = {
        variant = "";
        options = "";
        layout = "us,ru";
      };

      xrandrHeads = [
        {
          output = "eDP-1-1";
          primary = true;
          monitorConfig = ''
            Option "PreferredMode" "3456x2160"
            Option "Position" "0 0"
          '';
        }
        {
          output = "HDMI-1";
          monitorConfig = ''
            Option "PreferredMode" "1920x1080"
            Option "Position" "3456 0"
          '';
        }
      ];
    };
  };

  hardware.pulseaudio.enable = false;

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
    # Hyprland
    
    # DWM
    # picom
    # dmenu

    # icons
    pkgs.gnome3.adwaita-icon-theme
    pkgs.gtk-engine-murrine
    pkgs.gtk3

    # chromium video
    
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
    pkgs.xorg.xrandr
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
    vim
    neovim
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
    firefox
    prismlauncher
    brave

    # virtualization and nvidia
    qemu_kvm
    qpwgraph
    
    pciutils
    ncdu
    wireguard-tools

    php

    nvtopPackages.full
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
