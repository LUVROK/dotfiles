{ config, pkgs, lib, ... }:

{
  imports = [ ./config/vim.nix ./config/alacritty.nix ./config/touchpad.nix ];

  home.username = "dash";

  home.packages = with pkgs; [
    wget
    curl
    git
  ];

  home.homeDirectory = "/home/dash";
  home.stateVersion = "23.05";
}
