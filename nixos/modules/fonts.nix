{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      # --- icons ---
      adwaita-icon-theme
      gtk-engine-murrine
      gtk3
      vimix-gtk-themes

      # --- fonts ---
      noto-fonts
      noto-fonts-cjk-sans
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
