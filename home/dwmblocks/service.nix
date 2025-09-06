{ inputs, system, pkgs, lib, config, ... }:

let
  dwmblocksPkg = inputs.self.packages.${system}.dwmblocks;

  dbXkb = pkgs.writeShellApplication {
    name = "db-xkb";
    runtimeInputs = with pkgs; [ xorg.xset gnugrep gawk xkb-switch bash ];
    text = builtins.readFile ./shell/db-xkb;
    checkPhase = ":";
  };

  dbBattery = pkgs.writeShellApplication {
    name = "db-battery";
    runtimeInputs = with pkgs; [ libnotify acpi gawk coreutils bash ];
    text = builtins.readFile ./shell/db-battery;
    checkPhase = ":";
  };

  dbDate = pkgs.writeShellApplication {
    name = "db-date";
    runtimeInputs = with pkgs; [ libnotify util-linux gnused xorg.xrdb calcurse kitty coreutils bash ];
    text = builtins.readFile ./shell/db-date;
    checkPhase = ":";
  };

  dbMemory = pkgs.writeShellApplication {
    name = "db-memory";
    runtimeInputs = with pkgs; [ kitty btop procps gawk gnused coreutils bash ];
    text = builtins.readFile ./shell/db-memory;
    checkPhase = ":";
  };

  dbVolume = pkgs.writeShellApplication {
    name = "db-volume";
    runtimeInputs = with pkgs; [ wireplumber xdotool bc gnugrep coreutils kitty bash ];
    text = builtins.readFile ./shell/db-volume;
    checkPhase = ":";
  };

  dbWifi = pkgs.writeShellApplication {
    name = "db-wifi";
    runtimeInputs = with pkgs; [ iwd gnugrep gawk iputils coreutils bash ];
    text = builtins.readFile ./shell/db-wifi;
    checkPhase = ":";
  };
in
{
  home.packages = [
    dwmblocksPkg
    dbXkb
    dbBattery
    dbDate
    dbMemory
    dbVolume
    dbWifi
  ];

  systemd.user.services.dwmblocks = {
    Unit = {
      Description = "dwmblocks status bar";
      After = [ "graphical-session.target" "pipewire.service" "wireplumber.service" ];
      PartOf = [ "graphical-session.target" ];
      Wants = [ "pipewire.service" "wireplumber.service" ];
    };

    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
      ExecStart = "${dwmblocksPkg}/bin/dwmblocks";
      Restart = "on-failure";
      RestartSec = "2s";

      Environment = [
        "PATH=${lib.makeBinPath [
          dbXkb dbBattery dbDate dbMemory dbVolume dbWifi
        ]}"
      ];
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
