{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  imports = [ 
    ./config/vim.nix 
    ./config/touchpad.nix
  ];

  home.username = "dash";
  home.homeDirectory = "/home/dash";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    wget
    curl
    qemu-utils
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    direnv
    kitty
    neofetch
    p7zip
  
    neovim
    tree-sitter
    xclip
    
    sqlite
  ];

  programs = {
    alacritty = (import ./config/alacritty.nix { inherit pkgs; });
    ranger = (import ./config/ranger.nix { inherit pkgs; });
    kitty = (import ./config/kitty.nix { inherit pkgs; });
  };
}
