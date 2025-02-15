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

    # utils
    haskellPackages.greenclip

    # mergedScripts
  ];
}