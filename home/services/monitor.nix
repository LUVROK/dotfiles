{ lib, config, pkgs, ... }:

{  
  systemd.user.services.config-monitor = {
    Unit = {
      After = [ "graphical-session.target" "xdg-desktop-portal.service" "default.target" ];
      Wants = [ "graphical-session.target" "xdg-desktop-portal.service" "default.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${config.home.homeDirectory}/.local/bin/sh-others/dwm-xrandr";
      Environment = [
        "PATH=/home/dash/.local/bin/sh-others:${lib.makeBinPath [
          pkgs.bash 
          pkgs.coreutils 
          pkgs.xorg.xrandr 
        ]}"
        "DISPLAY=:0"
        "XAUTHORITY=${config.home.homeDirectory}/.Xauthority"
      ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}