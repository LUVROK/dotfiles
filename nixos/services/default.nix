{ pkgs, ... }:

{
  imports = [
    ./sound.nix
    ./syncthing.nix
    ./vnstat.nix
    ./display-managers
  ];

  services.v2raya = {
    enable = true;
    cliPackage = pkgs.xray;
  };
}
