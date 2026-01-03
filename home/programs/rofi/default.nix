{ config, lib, pkgs, inputs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    pass = {
      enable = true;
      package = pkgs.rofi-pass;
      stores = [ "$HOME/.password-store" ];
      extraConfig = import ./rofi-pass.nix { inherit lib pkgs config; };
    };
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = lib.mkDefault ./config/based.rasi; # pywal want to change these settings but its need espessialy for rofi pinentry (idk how force pinentry use this style in another way) TODO: figure it out). 1. maybe check default pywal rofi and if its just colors then do like ++ or smth and add my config or override default pywal config.
    extraConfig = {
      show-icons = false;
      # Remove some keys from the default bindings
      kb-accept-entry = "Control+m,Return,KP_Enter"; # Removed Control+j
      kb-remove-to-eol = ""; # Removed Control+k
      # Set our custom bindings
      kb-row-down = "Down,Control+n,Control+j";
      kb-row-up = "Up,Control+p,Control+k";
    };
  };

  xdg.configFile = {
    based-rasi = {
      source = ./config/based.rasi;
      target = "rofi/based.rasi";
    };
    rofi-pass-rasi = {
      source = ./config/rofi-pass.rasi;
      target = "rofi/rofi-pass.rasi";
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
    settings = {
      source = ./config/settings.rasi;
      target = "rofi/settings.rasi";
    };
    greenclip-offset = {
      source = ./config/greenclip-offset.rasi;
      target = "rofi/greenclip-offset.rasi";
    };
    powermenu-rasi = {
      source = ./config/power-menu.rasi;
      target = "rofi/power-menu.rasi";
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
