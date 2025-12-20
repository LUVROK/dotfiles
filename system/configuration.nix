{ config, lib, pkgs, pkgs-stable, inputs, username, ... }:

{
  imports = [
    ../nixos
    ./overlays
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
    dbus.enable = true;
    dbus.implementation = "broker";
    devmon.enable = true;
    displayManager.defaultSession = "none+dwm";
    blueman.enable = true;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  security.sudo.extraConfig = ''
    Defaults lecture = never
    Defaults timestamp_timeout=450
  '';

  programs.nix-ld.enable = true;

  services.journald.console = "/dev/tty4";
  services.earlyoom.enable = true;

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
      # "openrazer" # taint for kernel, need to be disable for raport
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

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  system.stateVersion = "24.11";
}
