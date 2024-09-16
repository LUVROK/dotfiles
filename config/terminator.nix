{ pkgs, ... }:

{
  enable = true;
  config = {
    global_config = {
      title_transmit_bg_color = "#171717";
      title_inactive_bg_color = "#171717";
      title_receive_bg_color = "#171717";
      title_fg_color = "#c5c8c6";
      hide_titlebar_when_maximized = true;
    };
    profiles = {
      default = {
        background_color = "#171717";
        foreground_color = "#c5c8c6";
        font = "JetBrainsMono 20";
        scrollbar_position = "hidden";
        padding_horizontal = 10;
        padding_vertical = 5;
        confirm_close = false;
      };
    };
  };
}
