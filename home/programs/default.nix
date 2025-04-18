{ lib, config, pkgs, ... }:

{
  imports = [
    ./neofetch.nix
    ./firefox
    ./ranger
    ./neovim
    ./vim
    ./git.nix
    ./rofi/rofi.nix
  ];

  home.file.".config/mpv".source = ./mpv;

  programs = {
    kitty = (import ./kitty/kitty.nix { inherit pkgs; });
  };
}