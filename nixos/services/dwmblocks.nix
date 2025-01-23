{ config, pkgs, ... }:

{
  systemd.services.dwmblocks = {
    description = "Status feed generator for dwm";
    wantedBy = [ "graphical-session.target" "multi-user.target" ];
    wants = [ "graphical-session.target" ];
    after = [
      "graphical-session.target"
      "network-online.target"
    ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "/home/dash/.local/bin/sh-dwmblocks/dwm-dwmblocks";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
