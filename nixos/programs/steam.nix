{ pkgs, ... }:

{
  imports = [
    # ./overlays/steam-nvidia.nix
  ];

  programs.steam.enable = true;
}