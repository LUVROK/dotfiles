{ config, lib, pkgs, inputs, ... }:

let
  dwm = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "dwm";
    rev = "455334d913c98d2a2919f5d92fdc235e0ab7e1da";
    hash = "sha256-itpe6xPSd0Tnz89QwO5XmJrjVmBiG1qa/PZgpTAGT6c=";
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
        version = "455334d913c98d2a2919f5d92fdc235e0ab7e1da";
        src = dwm;
      });
    })
    (import ./mpv-config.nix)
    inputs.nur.overlays.default
  ];
}
