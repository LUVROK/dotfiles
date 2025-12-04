{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    keepassxc
    keepmenu
  ];

  home.file = {
    ".config/keepmenu" = {
      source = ./keepmenu;
      recursive = true;
    };
  };
}
