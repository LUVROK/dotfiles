{ config, lib, pkgs, ... }:

{
  services.xserver = {
    windowManager.dwm = {
      enable = true;

      # package = pkgs.dwm.overrideAttrs {
        # src = ./dwm;
      # };
      
      package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        # src = ./dwm;
        src = ./dwm-gruvbox/dwm;

        patches = oldAttrs.patches or [] ++ [ 
          # ./dwm-gruvbox/dwm/patches/dwm-r1615-selfrestart.diff
          # ./dwm-gruvbox/dwm/patches/dwm-restartsig-20180523-6.2.diff
        ];

      });
    };

    displayManager.sessionCommands = ''
      WALLPAPER=/home/dash/Documents/wallpapers-gruvbox/minimalistic/
      feh --randomize --bg-fill "$WALLPAPER"*
      
      setxkbmap us,ru -option grp:win_space_toggle
      
      export PATH=/home/dash/HOME/dotfiles/system/dwm-gruvbox/dwmblocks:$PATH
      dwmblocks &
      devmon &

      while true; do
        dwm 2>~/.dwm.log
      done
    '';
  };

  environment.systemPackages = with pkgs; [
    dwmblocks
    dmenu
    nitrogen
    feh
  ];
}
