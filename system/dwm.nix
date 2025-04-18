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
      WALLPAPER=/home/dash/HOME/wizzard/wallpaper/game-of-thrones-kings-landing.png
      feh --geometry 3456x2160+0+0 --auto-zoom --bg-fill "$WALLPAPER"*
      
      export PATH=/home/dash/.local/bin/sh-dwmblocks:/home/dash/.local/bin/sh-others:/home/dash/.local/bin/sh-rofi:/home/dash/.local/bin/sh-nixos:$PATH
      xset -dpms &
      # devmon &
    '';
  };

  environment.systemPackages = with pkgs; [
    dmenu
    j4-dmenu-desktop
  ];
}
