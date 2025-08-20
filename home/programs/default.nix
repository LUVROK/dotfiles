{ lib, config, pkgs, ... }:

{
  imports = [
    ./neofetch.nix
    ./firefox
    ./ranger
    ./nnn
    ./neovim
    ./vim
    ./git.nix
    ./gpg
    ./rofi/rofi.nix
  ];

  home.file.".config/mpv".source = ./mpv;

  programs = {
    kitty = (import ./kitty/kitty.nix { inherit pkgs; });
  };
}