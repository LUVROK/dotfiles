{ config, lib, pkgs, ... }:

{
  imports = [
    ../../system/configuration.nix
    ../../system/hardware/amd.nix
    ./hardware-configuration.nix
  ];
}