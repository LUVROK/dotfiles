{ config, lib, pkgs, ... }:

{
  imports = [
    ../system/configuration.nix
    ../system/hardware/nvidia.nix
  ];
}