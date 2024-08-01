{ config, pkgs, lib, ... }:

{
  environment.variables = {
    EDITOR = "VIM";
    TERMINAL = "kitty";
    BROWSER = "chromium";

    # XCURSOR_THEME = lib.mkForce "Adwaita";
    # XCURSOR_PATH = lib.mkForce [ "${pkgs.simp1e-cursors}/share/icons" ];
    XCURSOR_PATH = lib.mkForce "/home/dash/.icons";

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    QT_SCREEN_SCALE_FACTORS = "2;2";
  };

  # environment.etc."X11/Xresources".text = ''
  #   Xcursor.theme: Adwaita
  #   Xcursor.size: 24
  # '';

  # Xcursor.theme: whiteglass
  # Xcursor.size: 20

  environment.etc."X11/xorg.conf.d/90-cursor.conf".text = ''
    Section "Extensions"
      Option "CoreXInput" "true"
    EndSection
  '';

  environment.etc."X11/xorg.conf.d/10-nvidia.conf".text = ''
    Section "ServerLayout"
      Identifier "layout"
      Screen 0 "intel"
      Inactive "nvidia"
    EndSection

    Section "Device"
      Identifier "nvidia"
      Driver "nvidia"
      BusID "PCI:1:0:0"
    EndSection

    Section "Screen"
      Identifier "nvidia"
      Device "nvidia"
    EndSection

    Section "Device"
      Identifier "intel"
      Driver "modesetting"
      BusID "PCI:0:2:0"
      Option "TearFree" "true"
    EndSection

    Section "Screen"
      Identifier "intel"
      Device "intel"
    EndSection
  '';

  environment.etc."X11/xorg.conf.d/50-touchpad.conf".text = ''
    Section "InputClass"
      Identifier "touchpad"
      Driver "libinput"
      MatchIsTouchpad "on"
      Option "Tapping" "on"
      Option "AccelSpeed" "0.7"
    EndSection
  '';
}