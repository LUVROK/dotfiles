{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./env.nix

    ../../system/configuration.nix
    ../../system/hardware/nvidia.nix

    ../../system/env.nix
    ../../system/dwm-flexipatch
    ../../system/bootloader.nix
    ../../system/xorg.nix
  ];
}