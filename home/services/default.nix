{ lib, config, ... }:

{
  imports = [
    ./activitywatch.nix
    ./dunst.nix
    ./flameshot.nix
    ./redshift.nix
    ./monitor.nix
  ];
}