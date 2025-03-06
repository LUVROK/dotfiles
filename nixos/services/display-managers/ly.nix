{ config, pkgs, ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "none";
      clock = "%c";
      lang = "en";
      load = true;
      numlock = false;
      save = true;
      input_len = 32;
      hide_borders = false;
      default_input = "login";
      clear_password = true;
    };
  };
}