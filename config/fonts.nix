{ config, pkgs, ... }:

{
  fonts = {
    enable = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      firacode
      jetbrains-mono
    ];
  };
}

