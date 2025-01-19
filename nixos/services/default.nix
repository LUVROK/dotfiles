{ lib, config, ... }:

{
  imports = [
    ./systemd-network.nix
    ./pipewire.nix
    ./syncthing.nix
    ./display-managers
  ];
}