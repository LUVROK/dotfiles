{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  rofi-wifi-menu = pkgs.writeScriptBin "rofi-wifi-menu" (builtins.readFile ./bin-rofi/rofi-wifi-menu.sh);
in {
  home.packages = with pkgs; [
    rofi-wifi-menu
    rofi-wayland
    rofi-power-menu
    rofi-bluetooth
    rofi-calc
    rofi-file-browser
  ];

  systemd.user.services.greenclip = {
    Unit = {
      Description = "Greenclip clipboard management daemon";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.haskellPackages.greenclip}/bin/greenclip daemon";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  xdg.configFile = {
    rofi-colors = {
      source = ./config/colors.rasi;
      target = "rofi/config/colors.rasi";
    };
    font-rasi = {
      source = ./config/font.rasi;
      target = "rofi/config/font.rasi";
    };
    launcher-bin = {
      source = ./bin-rofi/launcher.sh;
      target = "rofi/bin-rofi/launcher.sh";
    };
    launcher-rasi = {
      source = ./config/launcher.rasi;
      target = "rofi/config/launcher.rasi";
    };
    powermenu-bin = {
      source = ./bin-rofi/power-menu.sh;
      target = "rofi/bin-rofi/power-menu.sh";
    };
    powermenu-rasi = {
      source = ./config/power-menu.rasi;
      target = "rofi/config/power-menu.rasi";
    };
    confirm-rasi = {
      source = ./config/confirm.rasi;
      target = "rofi/config/confirm.rasi";
    };
    askpass-rasi = {
      source = ./config/ask-pass.rasi;
      target = "rofi/config/ask-pass.rasi";
    };
    runner-bin = {
      source = ./bin-rofi/runner.sh;
      target = "rofi/bin-rofi/runner.sh";
    };
    runner-rasi = {
      source = ./config/runner.rasi;
      target = "rofi/config/runner.rasi";
    };
    bluetooth-rasi = {
      source = ./config/bluetooth.rasi;
      target = "rofi/config/bluetooth.rasi";
    };
    network-rasi = {
      source = ./config/network.rasi;
      target = "rofi/config/network.rasi";
    };
    networkmenu-rasi = {
      source = ./config/network-menu.rasi;
      target = "rofi/config/network-menu.rasi";
    };
    mpd-rasi = {
      source = ./config/mpd.rasi;
      target = "rofi/config/mpd.rasi";
    };
    screenshot-bin = {
      source = ./bin-rofi/screenshot.sh;
      target = "rofi/bin-rofi/screenshot.sh";
    };
    screenshot-rasi = {
      source = ./config/screenshot.rasi;
      target = "rofi/config/screenshot.rasi";
    };
    greenclip-rasi = {
      source = ./clipmenu/greenclip.rasi;
      target = "rofi/config/greenclip.rasi";
    };
    greenclip-bin = {
      source = ./clipmenu/greenclip.sh;
      target = "rofi/bin-rofi/greenclip.sh";
    };
    greenclip-toml = {
      source = ./clipmenu/greenclip.toml;
      target = "greenclip.toml";
    };
  };
}