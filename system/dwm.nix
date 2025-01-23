{ config, lib, pkgs, ... }:

{
  imports = [
    ./picom.nix
  ];

  services.xserver = {
    windowManager.dwm = {
      enable = true;
      
      package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        src = ./dwm-flexipatch;
      });
    };

    displayManager.sessionCommands = ''
      WALLPAPER=/home/dash/HOME/wizzard/wallpaper/winter
      feh --geometry 3456x2160+0+0 --auto-zoom --randomize --bg-fill "$WALLPAPER"*
      
      export PATH=/home/dash/.local/bin/sh-dwmblocks:/home/dash/.local/bin/sh-others:/home/dash/.local/bin/sh-rofi:/home/dash/.local/bin/sh-nixos:$PATH
      xset -dpms &
      # dwm-dwmblocks &
      devmon &
    '';
  };

  environment.systemPackages = with pkgs; [
    dmenu
  ];
}
