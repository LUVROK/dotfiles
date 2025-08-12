{ lib, config, ... }:

{
  imports = [
    ./activitywatch.nix
    ./dunst.nix
    ./flameshot.nix
    ./redshift.nix
    ./pass-secret-service.nix
  ];
}