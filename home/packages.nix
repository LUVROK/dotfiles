{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    direnv
    kitty
    fish
    neofetch
    p7zip
    tree-sitter
    dunst
    rnnoise-plugin
    helvum
    ly

    # pass
    pinentry
    gnupg
    pass
    pwgen
    pass-secret-service

    # utils
    haskellPackages.greenclip
  ];
}