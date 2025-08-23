{ config, pkgs, lib, username, ... }:

{
  environment.variables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";

    # XCURSOR_PATH = lib.mkForce "/home/${username}/.icons";
    UDEVIL_CONF_PATH= "/etc/udevil/udevil.conf";

    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # QT_SCALE_FACTOR = "1";
    # QT_SCREEN_SCALE_FACTORS = "2;2";

    PASSWORD_STORE_DIR="$HOME/.password-store";

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
}
