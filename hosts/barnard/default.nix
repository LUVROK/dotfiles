{ config, lib, pkgs, ... }:

{
  imports = [
    ../../nixos
    ./hardware-configuration.nix
    ./env.nix
    ../../nixos/hardware/amd.nix
  ];

  config.videoDrivers = [ "amdgpu" ];
}
