{ config, lib, pkgs, ... }:

{
  services.xserver = {
    windowManager.dwm = {
      enable = true;
      
      package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        src = ./dwm-gruvbox/dwm;

        patches = oldAttrs.patches or [] ++ [ ];
      });
    };

    displayManager.sessionCommands = ''
      WALLPAPER=/home/dash/Documents/wallpapers-gruvbox/minimalistic/
      
      feh --randomize --bg-fill "$WALLPAPER"*
      setxkbmap us,ru -option grp:win_space_toggle
      
      export PATH=/home/dash/HOME/dotfiles/system/dwm-gruvbox/dwmblocks:$PATH
      dwmblocks &
      devmon &
    '';
  };


  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    fade = true;
  };

  environment.systemPackages = with pkgs; [
    dwmblocks
    dmenu
    nitrogen
    feh
    flameshot
  ];
}
