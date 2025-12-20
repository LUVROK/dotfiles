{ config, lib, pkgs, inputs, ... }:

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
    ./extraShell.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        pname = "dwm-flexipatch";
        version = "flexipatch-${builtins.substring 0 7 dwm-flexipatch-rev}";
        src = dwm-flexipatch;

        postPatch = ''
          cp ${./dwm-flexipatch/config.h} config.h
          cp ${./dwm-flexipatch/patches.h} patches.h
          touch gruvbox.h
          cp ${./dwm-flexipatch/gruvbox.h} gruvbox.h
        '';
      });
    })
    (import ./mpv-config.nix)
    inputs.nur.overlays.default
  ];
}
