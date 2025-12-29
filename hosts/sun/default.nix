{ config, lib, pkgs, ... }:

{
  imports = [
    ../../nixos
    ./hardware-configuration.nix
    ./env.nix
    ../../nixos/hardware/nvidia.nix
  ];

  config.videoDrivers = [
    "nvidia"
    "modesetting"
  ];
}
