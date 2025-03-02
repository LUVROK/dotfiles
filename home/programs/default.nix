{ lib, config, pkgs, ... }:

{
  imports = [
    ./neofetch.nix
    ./firefox
    ./ranger
    # ./nnn
    # ./vim/vim.nix
    ./neovim
    ./vim
    ./git.nix
    ./rofi/rofi.nix
  ];

  home.file.".config/mpv".source = ./mpv;

  # programs.git = {
  #   enable = true;
  #   userName = "LUVROK";
  #   userEmail = "pawel.2020.navtop@gmail.com";
  # };

  # home.packages = with pkgs; [
  #   gitAndTools.gitFull
  #   gh # github cli
  # ];

  programs = {
    kitty = (import ./kitty/kitty.nix { inherit pkgs; });
  };
}