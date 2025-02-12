{ lib, config, ... }:

{
  imports = [
    ./veracryt.nix
    ./extraShell.nix
    ./firefox.nix
  ];
}