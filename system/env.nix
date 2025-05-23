{ config, pkgs, lib, ... }:

{
  environment.variables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";

    XCURSOR_PATH = lib.mkForce "/home/dash/.icons";
    UDEVIL_CONF_PATH= "/etc/udevil/udevil.conf";

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    QT_SCREEN_SCALE_FACTORS = "2;2";

    PASSWORD_STORE_DIR="$HOME/HOME/.pass-store-mount";
    GNUPGHOME="$HOME/.gnupg";

    TERM="xterm-256color";
    TOR_SOCKS_PORT = "9050";

    MOZ_X11_EGL = "1";

    ROFI_PASS_CLIPBOARD_BACKEND = "xclip";
    ROFI_PASS_BACKEND = "xdotool";
  };

  xdg.mime = {
    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];
    };
  };

  environment.etc."X11/xorg.conf.d/00-keyboard.conf".text = ''
    Section "InputClass"
      Identifier "system-keyboard"
      MatchIsKeyboard "on"
      Option "XkbLayout" "us,ru"
      Option "XkbOptions" "grp:win_space_toggle"
    EndSection
  '';

  environment.etc."glvnd/egl_vendor.d/10_nvidia.json".text = ''
    {
      "file_format_version" : "1.0.0",
      "ICD" : {
        "library_path" : "/run/opengl-driver/lib/libEGL_nvidia.so"
      }
    }
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
      Option "PrimaryGPU" "false"
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
      Option "PreferredMode" "2560x1440"
      Option "Position" "3456 0"
      Option "Rate" "120.00"
    EndSection

    Section "Screen"
      Identifier "Screen1"
      Monitor "HDMI-1-0"
      Device "modesetting"
      SubSection "Display"
        Depth 24
        Modes "2560x1440"
        Virtual 7296 2160
      EndSubSection
    EndSection
  '';
}