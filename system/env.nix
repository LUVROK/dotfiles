{ config, pkgs, lib, ... }:

{
  environment.variables = {
    EDITOR = "VIM";
    TERMINAL = "kitty";
    BROWSER = "firefox";

    XCURSOR_PATH = lib.mkForce "/home/dash/.icons";
    PASSWORD_STORE_DIR=/home/dash/HOME/.pass-store-mount;
    UDEVIL_CONF_PATH=/etc/udevil/udevil.conf;

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    QT_SCREEN_SCALE_FACTORS = "2;2";
  };

  environment.etc."lightdm/lightdm-gtk-greeter.conf".text = ''
    [greeter]
    xft-dpi=192
  '';

  environment.etc."udevil/udevil.conf".text = ''
    allowed_users = *
    default_options = uid=dash,gid=dash
    
    allowed_devices = /dev/disk/by-uuid/f71e913d-c82e-4e0b-979d-9e7666aaa73b
    allowed_devices = /dev/disk/by-uuid/72840b24-be22-42b5-b27b-9d36bcbba346

    allowed_mount_point = /media/sda
    allowed_mount_point = /media/sdb1
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

  environment.etc."X11/xorg.conf.d/60-monitor.conf".text = ''
    Section "Monitor"
      Identifier "eDP-1"
      Option "PreferredMode" "3456x2160"
      Option "Position" "0 0"
      Option "DPI" "192 x 192"
      Option "Primary" "true"
    EndSection

    Section "Monitor"
      Identifier "HDMI-1-0"
      Option "PreferredMode" "1920x1080"
      Option "Position" "3456 0"
      Option "DPI" "96 x 96"
    EndSection

    Section "Screen"
      Identifier "Screen1"
      Monitor "HDMI-1-0"
      SubSection "Display"
        Depth 24
        Modes "1920x1080"
        Virtual 5376 2160
      EndSubSection
    EndSection
  '';
}