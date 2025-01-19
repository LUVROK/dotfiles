{ config, lib, pkgs, ... }:

{
  services.activitywatch = {
    package = pkgs.aw-server-rust;
    settings = {
      timeout = 180;
      port = 5600;
    };
  };

  systemd.user.services = {
    activitywatch = {
      Unit.Description = "Start ActivityWatch";
      Service.Type = "simple";
      Service.ExecStart = "${pkgs.activitywatch}/bin/aw-server";
      Install.WantedBy = [ "default.target" ];
      Service.Restart = "on-failure";
      Service.RestartSec = 5;
    };

    activitywatch-afk = {
      Unit.Description = "Start ActivityWatch AFK";
      Service.Type = "simple";
      Service.ExecStart = "${pkgs.activitywatch}/bin/aw-watcher-afk";
      Install.WantedBy = [ "default.target" ];
      Service.Restart = "on-failure";
      Service.RestartSec = 5;
    };

    activitywatch-window = {
      Unit.Description = "Start ActivityWatch Window";
      Service.Type = "simple";
      Service.ExecStart = "${pkgs.activitywatch}/bin/aw-watcher-window";
      Install.WantedBy = [ "default.target" ];
      Service.Restart = "on-failure";
      Service.RestartSec = 5;
    };
  };
}