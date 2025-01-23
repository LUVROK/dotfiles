{ lib, config, ... }:

{
  imports = [
    ./systemd-network.nix
    ./pipewire.nix
    ./syncthing.nix
    # ./dwmblocks.nix
    ./display-managers
  ];
}