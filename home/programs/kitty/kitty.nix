{ pkgs, ... }:

{
  enable = true;
  settings = {
    font_family = "JetBrainsMonoNL NFP";
    font_size = "14.0";

    window_padding_width = 2.5;
    window_padding_height = 2.5;

    confirm_os_window_close = 0;

    background = "#171717";
    foreground = "#ebdbb2";

    selection_foreground = "#928374";
    selection_background = "#3c3836";

    color0 = "#171717";
    color8 = "#928374";

    color1 = "#cc241d";   # red
    color9 = "#fb4934";   # light red

    color2 = "#98971a";   # green
    color10 = "#b8bb26";  # light green

    color3 = "#d79921";   # yellow
    color11 = "#fabd2d";  # light yellow

    color4 = "#458588";   # blue
    color12 = "#83a598";  # light blue

    color5 = "#b16286";   # magenta
    color13 = "#d3869b";  # light magenta

    color6 = "#689d6a";   # cyan
    color14 = "#8ec07c";  # light cyan

    color7 = "#a89984";   # light gray
    color15 = "#928374";  # dark gray
  };

  keybindings = {
    "ctrl+c" = "copy_or_interrupt";
    "ctrl+shift+c" = "copy_to_clipboard";
    "ctrl+v" = "paste_from_clipboard";
    "ctrl+q" = "exit";
  };
}
