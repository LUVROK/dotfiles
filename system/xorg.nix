{ config, lib, pkgs, username, ... }:

{
  services = {
    desktopManager.gnome.enable = false;

    logind = {
      powerKey = "ignore";
      powerKeyLongPress = "poweroff";

      extraConfig = ''
        [Login]
        IdleAction=ignore
        IdleActionSec=0
      '';
    };

    xserver = {
      /* xrandrHeads */
      enable = true;
      dpi = 112;
      upscaleDefaultCursor = true;
      logFile = null;

      xkb = {
        variant = "";
        options = "";
        layout = "us,ru";
      };

      displayManager.sessionCommands = ''
        WALLPAPER=/home/${username}/HOME/wizzard/wallpaper/game-of-thrones-kings-landing.png
        feh --geometry 3456x2160+0+0 --auto-zoom --bg-fill "$WALLPAPER"*
        
        export PATH=/home/${username}/.local/bin/sh-dwmblocks:/home/${username}/.local/bin/sh-others:/home/${username}/.local/bin/sh-rofi:/home/${username}/.local/bin/sh-nixos:$PATH
        xset -dpms &
        dwmblocks &
        greenclip daemon &
      '';

      serverFlagsSection = ''
        Option "DPMS" "true"
        Option "BlankTime"  "5"
        Option "StandbyTime" "10"
        Option "SuspendTime" "15"
        Option "OffTime"     "20"
      '';
    };
  };

  environment.systemPackages = with pkgs; [    
    # --- core utilities ---
    xorg.xorgserver
    xorg.libX11
    xorg.libX11.dev

    # --- xorg display & screen management ---
    xorg.libXrandr
    libxcvt
    xorg.xdpyinfo
    xorg.libXinerama
    xorg.libXrender

    # --- xorg input & keyboard tools ---
    xorg.xf86inputlibinput
    xorg.xmodmap
    xkb-switch
    evtest

    # --- xorg window & session utilities ---
    xorg.xwininfo
    xdotool
    wmctrl
    xorg.xev

    # --- xorg appearance & customization ---
    xorg.xsetroot
    xorg.xcursorthemes
    xsettingsd

    # --- clipboard & automation ---
    xclip
    xcolor
    xwinwrap
    xsel

    # --- xorg startup utilities ---
    xorg.xinit

    # --- XDG & system integration ---
    xdg-desktop-portal
  ];
}