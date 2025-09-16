{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./env.nix

    ../../system/configuration.nix
    ../../system/packages.nix
    ../../system/hardware/nvidia.nix

    ../../system/env.nix
    ../../system/dwm.nix
    ../../system/bootloader.nix
    ../../system/xorg.nix
  ];
}