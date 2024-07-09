{ config, pkgs, ... }:

{
  services.xserver = {
    windowManager.i3.enable = true;
    windowManager.i3.configFile = "/home/dash/.config/i3/config";
  };

  environment.systemPackages = with pkgs; [
    i3status
    dmenu
    picom
    networkmanagerapplet
    blueman
    udiskie
    feh
    pulseaudio
  ];
}

