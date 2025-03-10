{ lib, config, ... }:

{
  imports = [
    ./st
    ./overlays
    ./zsh
    ./steam.nix
  ];
}
