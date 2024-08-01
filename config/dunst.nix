{ config, pkgs, lib, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      experimental = {
        per_monitor_dpi = false;
      };

      global = {
        origin = "bottom-center";
        monitor = "0";
        follow = "mouse";
        geometry = "350x100-15+45";
        indicate_hidden = "yes";
        shrink = "yes";
        separator_height = "4";
        padding = "12";
        horizontal_padding = "20";
        frame_width = "0";
        sort = "no";
        idle_threshold = "120";
        font = "JetBrainsMonoNL NFP 12";
        line_height = "4";
        markup = "full";
        format = "%s\n%b";
        alignment = "center";
        show_age_threshold = "3000";
        word_wrap = "yes";
        ignore_newline = "no";
        transparency = "0%";
        stack_duplicates = "false";
        hide_duplicate_count = "yes";
        show_indicators = "no";
        icon_position = "left";
        max_icon_size = "32";
        sticky_history = "no";
        history_length = "20";
        always_run_script = "true";
        title = "Dunst";
        class = "Dunst";
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };

      urgency_low = {
        timeout = "4";
        foreground = "#ebdbb2";   # соответствие normfgcolor
        background = "#282828";   # соответствие normbgcolor
        frame_color = "#3c3836";  # соответствие normbordercolor
        highlight_color = "#292929";
        separator_color = "#292929";
        indicator_color = "#fbf1c7";
        progress_color = "#00ff00";
      };

      urgency_normal = {
        timeout = "8";
        foreground = "#fbf1c7";   # соответствие selfgcolor
        background = "#282828";   # соответствие selbgcolor
        frame_color = "#d65d0e";  # соответствие selbordercolor
        highlight_color = "#292929";
        separator_color = "#292929";
        indicator_color = "#fbf1c7";
        progress_color = "#00ff00";
      };

      urgency_critical = {
        timeout = "10";
        foreground = "#fbf1c7";   # соответствие urgfgcolor
        background = "#282828";   # соответствие urgbgcolor
        frame_color = "#ff0000";  # соответствие urgbordercolor
        highlight_color = "#292929";
        separator_color = "#292929";
        indicator_color = "#fbf1c7";
        progress_color = "#00ff00";
      };

      volume = {
        progress_color = "#00ff00";
      };
    };
  };
}
