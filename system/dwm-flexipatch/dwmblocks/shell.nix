{ pkgs ? import <nixpkgs> {} }:
 
pkgs.mkShell {
  buildInputs = [
    pkgs.xorg.libX11
    pkgs.gcc
    pkgs.makeWrapper
    pkgs.pkg-config
    pkgs.git
  ];
}
