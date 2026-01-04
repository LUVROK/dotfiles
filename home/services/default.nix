{ lib, config, ... }:

{
  imports = [
    ./dwmblocks
    ./dunst.nix
    ./flameshot.nix
    ./redshift.nix
    ./pass-secret-service.nix
  ];
}
