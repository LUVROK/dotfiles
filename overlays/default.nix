{
  self,
  inputs,
  config,
  pkgs,
  lib,
  ...
}: 

{
  nixpkgs.overlays = [ inputs.nur.overlays.default ];
}