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
    helvum
    ly

    # pass
    pinentry
    pwgen
    pass-secret-service
    libsecret

    # utils
    haskellPackages.greenclip
  ];
}
