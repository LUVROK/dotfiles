{ config, pkgs, lib, ... }:

{
  systemd.user.services.dwmblocks = {
    Unit = {
      Description = "Status feed generator for dwm";
      After = [ "default.target" "pipewire.service" "wireplumber.service" "network-online.target" ];
      Wants = [ "default.target" "pipewire.service" "wireplumber.service" "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "/home/dash/HOME/dotfiles/home/programs/dwmblocks-async/result/bin/dwmblocks";
      Restart = "always";
      RestartSec = 3;
      Environment = [
        "PATH=/home/dash/HOME/dotfiles/home/programs/dwmblocks-async/result/bin/:/home/dash/.local/bin/sh-dwmblocks/:${lib.makeBinPath [
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