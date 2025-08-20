{ config, pkgs, ... }:

{
  # nnn
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withIcons = false; });
  };
}