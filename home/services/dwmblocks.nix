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
      Environment = [
        "PATH=/home/dash/.local/bin/sh-dwmblocks:${lib.makeBinPath [
          pkgs.bash
          pkgs.coreutils
          pkgs.gnugrep
          pkgs.gnused
          pkgs.gawk
          pkgs.networkmanager
          pkgs.jq
          pkgs.curl
          pkgs.bc
          pkgs.xorg.xset
          pkgs.xkb-switch
          pkgs.procps
          pkgs.wireplumber
          pkgs.acpi
          pkgs.libnotify
          pkgs.xorg.xrdb
          pkgs.calcurse
          pkgs.util-linux
          pkgs.kitty
          pkgs.dbus
        ]}"
        "DISPLAY=:0"
        "XAUTHORITY=${config.home.homeDirectory}/.Xauthority"
      ];
    };
  };
}