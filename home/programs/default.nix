{ lib, config, pkgs, ... }:

{
  imports = [
    ./neofetch.nix
    ./vim/vim.nix
    ./rofi/rofi.nix
  ];

  home.file.".config/mpv".source = ./mpv;

  programs = {
    ranger = (import ./ranger.nix { inherit pkgs; });
    kitty = (import ./kitty/kitty.nix { inherit pkgs; });
  };
}