{ config, lib, pkgs, inputs, ... }:

let
  dwm = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "dwm";
    rev = "402943a2f93ecd3cdffc57ca57cc28bd1ac9b8ac";
    hash = "sha256-i78M9mv9OmRQ93kOQDOuqqG+rYpHsqEXNQTyl8pMlM4=";
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
        version = "402943a2f93ecd3cdffc57ca57cc28bd1ac9b8ac";
        src = dwm;
      });
    })
    (import ./mpv-config.nix)
    inputs.nur.overlays.default
  ];
}
