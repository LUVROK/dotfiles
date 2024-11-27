{ config, pkgs, lib, ... }:

{
  services.redshift = {
    enable = true;
    settings.redshift = {
      brightness-day = "1";
      brightness-night = "1";
      location-provider="manual";
      adjustment-method="vidmode"; # vidmode
      transition="1";
    };
    temperature = {
      day = 5500;
      night = 4500;
    };
    latitude = "37.4";
    longitude = "126.7";
  };

  systemd.user.services.redshift = lib.mkForce {
    Unit = {
      Description = "Redshift colour temperature adjuster";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };

    Service = { ExecStart = "${pkgs.redshift}/bin/redshift"; };
  };
}