{ config, lib, pkgs, ... }:

{
  services = {
    desktopManager.gnome.enable = false;
    # gnome.gnome-keyring.enable = false;

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
        WALLPAPER=/home/barnard/HOME/wizzard/wallpaper/game-of-thrones-kings-landing.png
        feh --geometry 3456x2160+0+0 --auto-zoom --bg-fill "$WALLPAPER"*
        
        export PATH=/home/barnard/.local/bin/sh-dwmblocks:/home/barnard/.local/bin/sh-others:/home/barnard/.local/bin/sh-rofi:/home/barnard/.local/bin/sh-nixos:$PATH
        xset -dpms &
        devmon &
        dwmblocks &
        greenclip daemon &
      '';

      serverFlagsSection = lib.mkDefault ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
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