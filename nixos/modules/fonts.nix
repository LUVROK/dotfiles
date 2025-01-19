{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      fira-code-symbols
      jetbrains-mono
      font-awesome_6
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.dejavu-sans-mono
    ];
  };
}
