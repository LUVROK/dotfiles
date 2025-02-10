{ config, lib, pkgs, ... }:

let
  displays = import ./known_displays.nix;
in
{
  programs.autorandr.profiles = {
    laptop = {
      fingerprint = { inherit (displays) eDP-1; };
      config = {
        eDP-1 = {
          enable = true;
          primary = true;
          position = "0x0";
          mode = "3456x2160";
          rate = "60.00";
        };
      };
    };
    laptop-monitor = {
      fingerprint = { inherit (displays) eDP-1 HDMI-1-0; };
      config = {
        eDP-1 = {
          enable = true;
          primary = true;
          position = "0x0";
          mode = "3456x2160";
          rate = "60.00";
        };
        HDMI-1-0 = {
          enable = true;
          primary = false;
          position = "3456x0";
          mode = "2560x1440";
          rate = "120.00";
        };
      };
    };
  };
}