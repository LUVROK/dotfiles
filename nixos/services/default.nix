{ lib, config, ... }:

{
  imports = [
    ./sound.nix
    ./syncthing.nix
    ./display-managers
  ];
}