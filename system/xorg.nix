{ config, lib, pkgs, ... }:

{
  services.xserver = {
    xkb = {
      variant = "";
      options = "";
      layout = "us,ru";
    };
  };

  environment.systemPackages = with pkgs; [    
    # --- core utilities ---
    xorg.xorgserver
    xorg.libX11
    xorg.libX11.dev

    # --- xorg display & screen management ---
    xorg.xrandr
    xorg.xdpyinfo
    xorg.libXinerama

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

    # --- xorg startup utilities ---
    xorg.xinit

    # --- XDG & system integration ---
    xdg-desktop-portal
  ];
}