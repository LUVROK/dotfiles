{ config, lib, pkgs, ... }:

{
  systemd.user.services.greenclip = {
    Unit = {
      Description = "Greenclip clipboard management daemon";
      After = [ "display-manager.service" "default.target" "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.haskellPackages.greenclip}/bin/greenclip daemon";
      Environment = [
        "DISPLAY=:0"
        "XAUTHORITY=${config.home.homeDirectory}/.Xauthority"
      ];
    };

    Install = { WantedBy = [ "default.target" "graphical-session.target" ]; };
  };
}