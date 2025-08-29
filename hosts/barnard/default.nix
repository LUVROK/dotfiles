{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./env.nix

    ../../system/configuration.nix
    ../../system/hardware/amd.nix

    ../../system/env.nix
    ../../system/dwm-flexipatch
    ../../system/bootloader.nix
    ../../system/xorg.nix
  ];
}