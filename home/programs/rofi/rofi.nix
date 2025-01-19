{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
# with lib; let
#   rofi-wifi-menu = pkgs.writeScriptBin "rofi-wifi-menu" (builtins.readFile "$HOME/.local/bin/sh-rofi/rofi-wifi-menu.sh");
# in 
{
  home.packages = with pkgs; [
    # rofi-wifi-menu
    rofi-wayland
    rofi-power-menu
    rofi-bluetooth
    rofi-calc
    # rofi-file-browser
  ];

  xdg.configFile = {
    rofi-colors = {
      source = ./config/colors.rasi;
      target = "rofi/config/colors.rasi";
    };
    font-rasi = {
      source = ./config/font.rasi;
      target = "rofi/config/font.rasi";
    };
    launcher-rasi = {
      source = ./config/launcher.rasi;
      target = "rofi/config/launcher.rasi";
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
    screenshot-rasi = {
      source = ./config/screenshot.rasi;
      target = "rofi/config/screenshot.rasi";
    };
    greenclip-rasi = {
      source = ./clipmenu/greenclip.rasi;
      target = "rofi/config/greenclip.rasi";
    };
    greenclip-toml = {
      source = ./clipmenu/greenclip.toml;
      target = "greenclip.toml";
    };
  };
}