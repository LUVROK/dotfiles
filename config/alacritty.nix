{ pkgs, config, inputs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#171717";
          foreground = "#c5c8c6";
        };
      };
      font = {
        normal.family = "JetBrainsMono";
        size = 10.0;
      };
      window = {
        padding = {
          x = 10;
          y = 10;
        };
      };
    };
  };
}
