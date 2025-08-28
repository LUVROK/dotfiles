{ config, lib, pkgs, ... }:

{
  imports = [
    ../../system/configuration.nix
    ../../system/hardware/nvidia.nix

    ../../system/env.nix
    ../../system/dwm-flexipatch
    ../../system/bootloader.nix
    ../../system/xorg.nix

    ./hardware-configuration.nix
    ./env.nix
  ];
}