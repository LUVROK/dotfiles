{ config, lib, pkgs, ... }:

{
  imports = [
    ./picom.nix
  ];

  services.xserver.windowManager.dwm = {
    enable = true;
    
    package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
      src = ./dwm-flexipatch;
    });
  };

  environment.systemPackages = with pkgs; [
    dmenu
    j4-dmenu-desktop
  ];
}
