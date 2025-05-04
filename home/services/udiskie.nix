{ lib, config, pkgs, ... }:

let
  yaml = pkgs.formats.yaml { };
in
{  
  # services.gvfs.enable = true;
  # services.devmon.enable = true;

  # services.udisks2.enable = true;

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

  xdg.configFile."udiskie/config.yml".source = yaml.generate "config.yml" {
    program_options = {
      automount = true;
      udisks_version = 2;
      tray = false;
      notify = false;
    };
  };
}