{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "LUVROK";
    userEmail = "pawel.2020.navtop@gmail.com";
  };

  home.packages = with pkgs; [
    gh # github cli
    git-crypt
  ];
}