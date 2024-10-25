{ config, lib, pkgs, ... }:

{
  imports = [
    ../config/picom.nix
  ];

  services.xserver = {
    windowManager.dwm = {
      enable = true;
      
      package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        src = ./dwm-flexipatch;
      });
    };

    /* setxkbmap us,ru -option grp:win_space_toggle */

    displayManager.sessionCommands = ''
      WALLPAPER=/home/dash/HOME/wizzard/wallpaper/antiquity
      
      feh --geometry 3456x2160+0+0 --auto-zoom --randomize --bg-fill "$WALLPAPER"*
      
      export PATH=/home/dash/HOME/dotfiles/system/dwm-flexipatch/dwmblocks:$PATH
      xset -dpms &
      dwmblocks &
      devmon &
    '';
  };

  environment.systemPackages = with pkgs; [
    dwmblocks
    dmenu
    dmenu-rs
    nitrogen
    feh

    pa_applet
    networkmanager_dmenu
    dzen2
  ];
}
