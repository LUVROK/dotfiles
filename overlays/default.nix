{
  self,
  inputs,
  config,
  pkgs,
  lib,
  ...
}: 

{
  imports = [ 
    ./extraShell.nix
    # ./nix-alien.nix
    # ./firefox.nix
  ];
}