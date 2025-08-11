{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    pass = {
      enable = true;
      package = pkgs.rofi-pass;
      stores = [ "$HOME/.password-store" ];
    };
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = ./config/theme.rasi;
  };

  xdg.configFile = {
    rofi-colors = {
      source = ./config/colors.rasi;
      target = "rofi/colors.rasi";
    };
    font-rasi = {
      source = ./config/font.rasi;
      target = "rofi/font.rasi";
    };
    launcher-rasi = {
      source = ./config/launcher.rasi;
      target = "rofi/launcher.rasi";
    };
    powermenu-rasi = {
      source = ./config/power-menu.rasi;
      target = "rofi/power-menu.rasi";
    };
    crypto-rasi = {
      source = ./config/crypto-menu.rasi;
      target = "rofi/crypto-menu.rasi";
    };
    confirm-rasi = {
      source = ./config/confirm.rasi;
      target = "rofi/confirm.rasi";
    };
    askpass-rasi = {
      source = ./config/ask-pass.rasi;
      target = "rofi/ask-pass.rasi";
    };
    runner-rasi = {
      source = ./config/runner.rasi;
      target = "rofi/runner.rasi";
    };
    bluetooth-rasi = {
      source = ./config/bluetooth.rasi;
      target = "rofi/bluetooth.rasi";
    };
    network-rasi = {
      source = ./config/network.rasi;
      target = "rofi/network.rasi";
    };
    networkmenu-rasi = {
      source = ./config/network-menu.rasi;
      target = "rofi/network-menu.rasi";
    };
    mpd-rasi = {
      source = ./config/mpd.rasi;
      target = "rofi/mpd.rasi";
    };
    screenshot-rasi = {
      source = ./config/screenshot.rasi;
      target = "rofi/screenshot.rasi";
    };
    greenclip-rasi = {
      source = ./clipmenu/greenclip.rasi;
      target = "rofi/greenclip.rasi";
    };
    greenclip-toml = {
      source = ./clipmenu/greenclip.toml;
      target = "greenclip.toml";
    };
  };
}