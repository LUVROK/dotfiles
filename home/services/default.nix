{ lib, config, ... }:

{
  imports = [
    ./activitywatch.nix
    ./dunst.nix
    ./flameshot.nix
    ./dwmblocks.nix
    ./redshift.nix
    ./greenclip.nix
    # ./udiskie.nix 
    ./second-monitor.nix
  ];
}