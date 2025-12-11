{ config, pkgs, lib, ... }:

{
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [
      exts.pass-import # a generic importer tool from other password managers
    ]);
  };

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
    pavucontrol
    helvum
    ly

    # pass
    pinentry-curses
    pwgen
    pass-secret-service
    libsecret

    # utils
    haskellPackages.greenclip
  ];
}
