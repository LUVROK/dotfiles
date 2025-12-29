{ config, lib, pkgs, inputs, ... }:

let
  dwm = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "dwm";
    rev = "fe090520ed7c0cae20bee28e4967ea6179ce42b6";
    hash = "sha256-uTIWcclMFsQsJ/rtmsg1cCaqnTuy/DxdieN3a3D3k5w=";
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
        version = "fe090520ed7c0cae20bee28e4967ea6179ce42b6";
        src = dwm;
      });
    })
    (import ./mpv-config.nix)
    inputs.nur.overlays.default
  ];
}
