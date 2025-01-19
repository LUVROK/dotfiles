{ config, pkgs, lib, ... }:

{
  systemd.user.services.dwmblocks = {
    Unit = {
      Description = "Status feed generator for dwm";
      After = [ "default.target" ];
      Wants = [ "default.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${config.home.homeDirectory}/.local/bin/sh-dwmblocks/dwm-dwmblocks";
      Restart = "always";
      RestartSec = 3;
    };
  };
}
