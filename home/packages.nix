{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # based
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
    pass
    pwgen
    pass-secret-service
    libsecret

    # utils
    haskellPackages.greenclip
  ];
}
