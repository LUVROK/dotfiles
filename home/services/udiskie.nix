{ lib, config, pkgs, ... }:

{  
  # services.gvfs.enable = true;
  # services.devmon.enable = true;

  systemd.user.services.udiskie = {
    Service = {
      Type = "simple";
      Restart = "always";
      RestartSec = "1";
      ExecStart = "${pkgs.udiskie}/bin/udiskie -c /etc/udiskie.yml";
    };

    Unit = {
      After = [ "graphical-session.target" "xdg-desktop-portal.service" "default.target" ];
      Wants = [ "graphical-session.target" "xdg-desktop-portal.service" "default.target" ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}