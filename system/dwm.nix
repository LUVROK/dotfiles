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

    displayManager.sessionCommands = ''
      # Запуск xwinwrap с параметрами для живых обоев
      # xwinwrap -ov -fs -- mpv -wid WID -loop 0 -no-audio /home/dash/HOME/wizzard/wallpaper/live/winter-house-moewalls-com.mp4 &

      # Ждём немного, чтобы xwinwrap запустился
      # sleep 5

      # Делаем окно xwinwrap "липким" (на всех рабочие пространствах)
      # wmctrl -r :ACTIVE: -b add,sticky

      # ------

      WALLPAPER=/home/dash/HOME/wizzard/wallpaper/winter
      
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
