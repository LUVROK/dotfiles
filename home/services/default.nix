{ lib, config, ... }:

{
  imports = [
    ./activitywatch.nix
    ./dunst.nix
    ./flameshot.nix
    ./dwmblocks.nix
    ./redshift.nix
    ./greenclip.nix
  ];
}