{ lib, config, ... }:

{
  imports = [
    ./sound.nix
    ./syncthing.nix
    ./vnstat.nix
    ./razer.nix
    ./display-managers
  ];
}