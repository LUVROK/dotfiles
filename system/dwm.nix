{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./picom.nix
  ];

  services.xserver.windowManager.dwm = {
    enable = true;
    # package = pkgs.dwm;
    package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        src = ./dwm;
    });
  };

  environment.systemPackages = with pkgs; [
    dmenu
    j4-dmenu-desktop
  ];
}
