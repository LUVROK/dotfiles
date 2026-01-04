{ lib, config, pkgs, ... }:

{
  imports = [
    ./firefox
    ./ranger
    ./nnn
    ./neovim
    ./zsh
    ./rofi
    ./git.nix
    ./xresources.nix
    ./gpg.nix
    ./mpv.nix
    ./neofetch.nix
  ];

  programs = {
    kitty = (import ./kitty/kitty.nix { inherit pkgs; });
    obs-studio = (import ./obs-studio.nix { inherit pkgs; });
    pywal.enable = false;
  };
}
