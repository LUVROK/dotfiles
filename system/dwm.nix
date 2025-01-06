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
      
      export PATH=/home/dash/HOME/dotfiles/system/dwm-flexipatch/dwmblocks-async/result/bin:/home/dash/.local/bin:$PATH
      xset -dpms &
      devmon &
    '';
  };

  environment.systemPackages = with pkgs; [
    dmenu
  ];
}
