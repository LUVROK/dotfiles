{ config, lib, pkgs, ... }:

{
  services.xserver = {
    windowManager.dwm = {
      enable = true;
      
      package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        # src = ./dwm-gruvbox/dwm;
        src = ./dwm-flexipatch;

        patches = oldAttrs.patches or [] ++ [
          # "./patches/dwm-systray-6.3.diff"
          # "./patches/dwm-steam.diff"
        ];
      });
    };

    displayManager.sessionCommands = ''
      WALLPAPER=/home/dash/HOME/wizzard/wallpaper/antiquity
      
      feh --randomize --bg-fill "$WALLPAPER"*
      setxkbmap us,ru -option grp:win_space_toggle
      
      export PATH=/home/dash/HOME/dotfiles/system/dwm-flexipatch/dwmblocks:$PATH
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
    dmenu-rs
    nitrogen
    feh
    flameshot

    pa_applet
    networkmanager_dmenu
    dzen2
  ];
}
