{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sway
    waybar
    wofi
    dmenu
    shotman
    clipcat
    mako
  ];

  services.xserver.windowManager.sway = {
    enable = true;
    package = pkgs.sway;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;

    config = rec {
      modifier = "Mod4";
      output = {
        "HDMI-0" = {
          mode = "1920x1080@60Hz";
          pos = "3456 0";
        };
        "eDP-1-1" = {
          mode = "3456x2160@60Hz";
          pos = "0 0";
        };
      };
    };
    extraConfig = ''
      bindsym Print               exec shotman -c output
      bindsym Print+Shift         exec shotman -c region
      bindsym Print+Shift+Control exec shotman -c window
    '';
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  # programs.rofi.enable = true;

  # services.swaylock.enable = true;
  # services.swayidle.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd sway
      '';
    };
  };

  # environment.etc."greetd/environments".text = ''
    # sway
  # '';
}

