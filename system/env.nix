{ config, pkgs, lib, ... }:

{
  environment.variables = {
    EDITOR = "VIM";
    TERMINAL = "kitty";
    BROWSER = "firefox";

    XCURSOR_PATH = lib.mkForce "/home/dash/.icons";
    UDEVIL_CONF_PATH=/etc/udevil/udevil.conf;

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    QT_SCREEN_SCALE_FACTORS = "2;2";

    PASSWORD_STORE_DIR="$HOME/HOME/wizzard/hogsmeade";
    GNUPGHOME="$HOME/.gnupg";

    TERM="xterm-256color";
  };

  xdg.mime = {
    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];
    };
  };

  environment.etc."nixos/home/images/neofetch.png" = {
    source = "/home/dash/HOME/dotfiles/config/media/neofetch.png";
  };

  environment.etc."udevil/udevil.conf".text = ''
    allowed_users = *
    default_options = uid=dash,gid=dash,umask=0077
  '';

  environment.etc."X11/xorg.conf.d/00-keyboard.conf".text = ''
    Section "InputClass"
      Identifier "system-keyboard"
      MatchIsKeyboard "on"
      Option "XkbLayout" "us,ru"
      Option "XkbOptions" "grp:win_space_toggle"
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
      Option "Scale" "2x2"
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