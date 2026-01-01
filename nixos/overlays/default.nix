{ config, lib, pkgs, inputs, ... }:

let
  dwm = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "dwm";
    rev = "49d4b067e8c5889a5b07707a33705c2be79899d3";
    hash = "sha256-EE0XTwpOO4PLlrSIDEfQDDAtfMAln4jjBYu6l5+JEL0=";
  };
in
{
  imports = [
    ./extraShell.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        pname = "dwm";
        version = "49d4b067e8c5889a5b07707a33705c2be79899d3";
        src = dwm;
      });
    })
    (import ./mpv-config.nix)
    inputs.nur.overlays.default
  ];
}
