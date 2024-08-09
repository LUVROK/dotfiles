{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gnumake
    pkgs.xorg.libX11
  ];
}