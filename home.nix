{ config, pkgs, lib, ... }:

{
  imports = [ ./config/vim.nix ./config/alacritty.nix ./config/touchpad.nix ];

  home.username = "dash";

  home.packages = with pkgs; [
    wget
    curl
    qemu-utils
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
  ];

  fonts = {
    fontconfig.enable = true;
  };

  home.homeDirectory = "/home/dash";
  home.stateVersion = "23.05";
}
