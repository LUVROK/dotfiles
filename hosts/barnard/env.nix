{ config, pkgs, lib, ... }:

{

  environment.sessionVariables = {
    XFT_DPI = "112";
  };

  environment.etc."X11/xorg.conf.d/60-monitor.conf".text = ''
    Section "Monitor"
      Identifier "HDMI-A-0"
      Modeline "2560x1440R"  497.25  2560 2608 2640 2720  1440 1443 1448 1525 +hsync -vsync
      Option "PreferredMode" "2560x1440R"
      Option "Position" "0 0"
      Option "Primary" "true"
    EndSection
    Section "Monitor"
      Identifier "DisplayPort-0"
      Modeline "2560x1440R"  497.25  2560 2608 2640 2720  1440 1443 1448 1525 +hsync -vsync
      Option "PreferredMode" "2560x1440R"
      Option "Position" "-2560 0"
    EndSection
  '';
}
