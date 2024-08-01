{ pkgs, ... }:

{
  enable = true;
  settings = {
    background = "#171717";
    foreground = "#c5c8c6";
    
    font_family = "JetBrainsMono";
    font_size = "20.0";

    window_padding_width = 10;
    window_padding_height = 5;

    confirm_os_window_close = 0;
  };
}
