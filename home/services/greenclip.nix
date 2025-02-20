{ config, lib, pkgs, ... }:

{
  systemd.user.services.greenclip = {
    Unit = {
      Description = "Greenclip clipboard management daemon";
      After = [ "graphical-session.target" "display-manager.service" ];
    };

    Service = {
      ExecStart = "${pkgs.haskellPackages.greenclip}/bin/greenclip daemon";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}