{ lib, config, ... }:

{
  imports = [
    ./sound.nix
    ./syncthing.nix
    ./vnstat.nix
    ./display-managers
  ];
}