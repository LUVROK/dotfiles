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
  ];
  
  nixpkgs.overlays = [ inputs.nur.overlay ];
}