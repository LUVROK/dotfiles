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
    ./mpv
    ./rofi/rofi.nix
    ./zsh
  ];

  programs = {
    kitty = (import ./kitty/kitty.nix { inherit pkgs; });
    obs-studio = (import ./obs-studio.nix { inherit pkgs; });
  };
}
