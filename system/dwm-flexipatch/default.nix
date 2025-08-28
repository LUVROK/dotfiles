{ config, lib, pkgs, ... }:

let
  dwm-flexipatch-rev = "10104fbc9ad3b7c68cfa38b7f387d83e82388ea6";
  dwm-flexipatch = pkgs.fetchFromGitHub {
    owner = "bakkeby";
    repo = "dwm-flexipatch";
    rev = dwm-flexipatch-rev;
    hash = "sha256-+6NrjxdbCnv9ZB0MvZ1+mWyxrEncQF14gijGPoWIhhY=";
  };
in
{
  imports = [
    ../picom.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        pname = "dwm-flexipatch";
        version = "flexipatch-${builtins.substring 0 7 dwm-flexipatch-rev}";
        src = dwm-flexipatch;

        # подмена конфигов до сборки
        postPatch = ''
          cp ${./config.h} config.h
          cp ${./patches.h} patches.h
          touch gruvbox.h
          cp ${./gruvbox.h} gruvbox.h
        '';
      });
    })
  ];

  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm;
    
    # package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
    #   src = ./dwm-flexipatch;
    # });
  };

  environment.systemPackages = with pkgs; [
    dmenu
    j4-dmenu-desktop
  ];
}
