{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  imports = [ 
    ./config/vim.nix
    ./system/cursor.nix
    ./config/rofi/rofi.nix
    ./config/dunst.nix
  ];

  home.username = "dash";
  home.homeDirectory = "/home/dash";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    direnv
    kitty
    neofetch
    p7zip
    neovim
    tree-sitter
    dunst
    gnupg
  ];

  home.file.".gnupg/gpg-agent.conf" = {
    text = ''
      pinentry-program ${pkgs.pinentry}/bin/pinentry
    '';
    onChange = ''
      echo "Reloading gpg-agent"
      echo RELOADAGENT | gpg-connect-agent
    '';
  };

  programs = {
    alacritty = (import ./config/alacritty.nix { inherit pkgs; });
    ranger = (import ./config/ranger.nix { inherit pkgs; });
    kitty = (import ./config/kitty.nix { inherit pkgs; });
  };
}
