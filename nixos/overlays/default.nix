{ config, lib, pkgs, inputs, ... }:

let
  dwm = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "dwm";
    rev = "455334d913c98d2a2919f5d92fdc235e0ab7e1da";
    hash = "sha256-itpe6xPSd0Tnz89QwO5XmJrjVmBiG1qa/PZgpTAGT6c=";
  };
  st = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "st";
    rev = "0723b7e39e73b2bcfce047b047f6e795d6184028";
    hash = "sha256-A1AGAoxSPBJKEbj6M2bBBujMchSKc+IhDPdi03cTASY=";
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
    (final: prev: {
      st = prev.st.overrideAttrs (old: {
        pname = "st";
        version = "0723b7e39e73b2bcfce047b047f6e795d6184028";
        src = st;
      });
    })
    (import ./mpv-config.nix)
    inputs.nur.overlays.default
  ];
}
