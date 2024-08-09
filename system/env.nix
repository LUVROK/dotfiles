{ config, pkgs, lib, ... }:

{
  environment.variables = {
    EDITOR = "VIM";
    TERMINAL = "kitty";
    BROWSER = "firefox";

    # XCURSOR_THEME = lib.mkForce "Adwaita";
    # XCURSOR_PATH = lib.mkForce [ "${pkgs.simp1e-cursors}/share/icons" ];
    
    XCURSOR_PATH = lib.mkForce "/home/dash/.icons";
    PASSWORD_STORE_DIR=/home/dash/HOME/.pass-store-mount;

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    QT_SCREEN_SCALE_FACTORS = "2;2";
  };

  # environment.etc."X11/Xresources".text = ''
  #   Xcursor.theme: Adwaita
  #   Xcursor.size: 24
  # '';

  environment.etc."X11/xorg.conf.d/60-monitor.conf".text = ''
    Section "Monitor"
        Identifier "eDP-1"
        Option "PreferredMode" "3456x2160"
        Option "Position" "0 0"
        Option "DPI" "192"
    EndSection

    Section "Monitor"
        Identifier "HDMI-1-0"
        Option "PreferredMode" "1920x1080"
        Option "Position" "3456 0"
        Option "DPI" "96"
    EndSection

    Section "Screen"
        Identifier "Screen0"
        Monitor "eDP-1"
        SubSection "Display"
            Virtual 5376 2160
        EndSubSection
    EndSection

    Section "Screen"
        Identifier "Screen1"
        Monitor "HDMI-1-0"
        SubSection "Display"
            Virtual 5376 2160
        EndSubSection
    EndSection
  '';

  environment.etc."udevil/udevil.conf".text = ''
    default_options = uid=1000,gid=1000,umask=0022
    device /dev/sdb1 {
        mount_point = /media/SATA-01
        options = noexec,nodev,noatime
    }
  '';

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