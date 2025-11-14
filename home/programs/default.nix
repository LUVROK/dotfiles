{ lib, config, pkgs, nixosConfig, ... }:

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
  ];

  programs = {
    kitty = (import ./kitty/kitty.nix { inherit pkgs nixosConfig; });
    obs-studio = (import ./obs-studio.nix { inherit pkgs; });
  };
}
