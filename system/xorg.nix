{ config, lib, pkgs, ... }:

{
  services = {
    gnome.gnome-keyring.enable = true;
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
      enable = true;
      dpi = 192;
      upscaleDefaultCursor = true;
      logFile = null;

      xkb = {
        variant = "";
        options = "";
        layout = "us,ru";
      };

      displayManager.sessionCommands = ''
        WALLPAPER=/home/dash/HOME/wizzard/wallpaper/game-of-thrones-kings-landing.png
        feh --geometry 3456x2160+0+0 --auto-zoom --bg-fill "$WALLPAPER"*
        
        export PATH=/home/dash/.local/bin/sh-dwmblocks:/home/dash/.local/bin/dwmblocks:/home/dash/.local/bin/sh-others:/home/dash/.local/bin/sh-rofi:/home/dash/.local/bin/sh-nixos:$PATH
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

      # deviceSection = ''
      #   Option         "TripleBuffer" "on"
      # '';

      # screenSection = ''
      #   Option         "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      #   Option         "AllowIndirectGLXProtocol" "off"
      # '';
    };
  };

    # Отключаем sleep
  # environment.etc."systemd/logind.conf.d/99-ignore-sleep.conf".text = ''
  #   [Login]
  #   HandleLidSwitch=ignore
  #   HandleSuspendKey=ignore
  #   HandleHibernateKey=ignore
  # '';

  # Включаем DEBUG для systemd-logind
  # environment.etc."systemd/system/systemd-logind.service.d/override.conf".text = ''
  #   [Service]
  #   Environment=SYSTEMD_LOG_LEVEL=debug
  # '';

  environment.systemPackages = with pkgs; [    
    # --- core utilities ---
    xorg.xorgserver
    xorg.libX11
    xorg.libX11.dev

    # --- xorg display & screen management ---
    xorg.libXrandr
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