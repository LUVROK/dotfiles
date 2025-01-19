{ lib, config, ... }:

{
  imports = [
    ./fonts.nix
    # ./games.nix
    # ./iphone.nix
    ./qmk.nix
    ./touchpad.nix
    ./virtualisation.nix
  ];
}