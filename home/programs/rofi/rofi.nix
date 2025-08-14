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
    theme = ./config/based.rasi;
  };

  xdg.configFile = {
    based-rasi = {
      source = ./config/based.rasi;
      target = "rofi/based.rasi";
    };
    pinentry-theme-rasi = {
      source = ./config/pinentry-theme.rasi;
      target = "rofi/pinentry-theme.rasi";
    };
    keyring-rasi = {
      source = ./config/keyring.rasi;
      target = "rofi/keyring.rasi";
    };
    colors-rasi = {
      source = ./config/colors.rasi;
      target = "rofi/colors.rasi";
    };
    firefox-rasi = {
      source = ./config/firefox-profiles-menu.rasi;
      target = "rofi/firefox-profiles-menu.rasi";
    };
    font-rasi = {
      source = ./config/font.rasi;
      target = "rofi/font.rasi";
    };
    powermenu-rasi = {
      source = ./config/power-menu.rasi;
      target = "rofi/power-menu.rasi";
    };
    crypto-rasi = {
      source = ./config/crypto-menu.rasi;
      target = "rofi/crypto-menu.rasi";
    };
    greenclip-rasi = {
      source = ./greenclip/greenclip.rasi;
      target = "rofi/greenclip.rasi";
    };
    greenclip-toml = {
      source = ./greenclip/greenclip.toml;
      target = "greenclip.toml";
    };
  };
}