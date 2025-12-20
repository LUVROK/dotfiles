{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;
    settings = {
      user.email = "morturion.life@gmail.com";
      user.name = "Luvrok";
    };
  };

  home.packages = with pkgs; [
    gh
    git-crypt
  ];
}
