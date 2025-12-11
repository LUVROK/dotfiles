{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;
  };

  home.packages = with pkgs; [
    gh
    git-crypt
  ];
}
