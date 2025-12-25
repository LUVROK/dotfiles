{ config, lib, pkgs, inputs, ... }:

let
  dwm = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "dwm";
    rev = "1b598056c322d4fe9ddcc4e4e268ee5a14a995f0";
    hash = "sha256-7dJ8OikrGWZOoCAHudp21YDJ53u2PVrQjMUNslpHpY4=";
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
        version = "1b598056c322d4fe9ddcc4e4e268ee5a14a995f0";
        src = dwm;
      });
    })
    (import ./mpv-config.nix)
    inputs.nur.overlays.default
  ];
}
