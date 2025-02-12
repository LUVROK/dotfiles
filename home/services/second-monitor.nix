{ lib, config, pkgs, ... }:

# TODO:
#   description: xorg need work with intel intergration graphics and everything will be great, bcs its bad support with nvidia as i know. I use picom,
#     x11, dwm (dynamic window manager) and NIXOS.
#   problem: xrandr work bad with nvidia proprietary drivers, we need use intel integration graphics and i do, but for some reason i have xorg failed (in logs problem with nvidia idk why) after second use of xrandr (only if i put off hdmi cabel after using xrandr)
#     and this code just start xrandr settings for my second monitor with start xorg session. It not decide my problem, but minimize it 
#   task: decide this problem

{  
  systemd.user.services.config-monitor = {
    Unit = {
      After = [ "graphical-session.target" "xdg-desktop-portal.service" "default.target" ];
      Wants = [ "graphical-session.target" "xdg-desktop-portal.service" "default.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${config.home.homeDirectory}/.local/bin/sh-others/dwm-xrandr";
      Environment = [
        "PATH=/home/dash/.local/bin/sh-others:${lib.makeBinPath [
          pkgs.bash 
          pkgs.coreutils 
          pkgs.xorg.xrandr 
          pkgs.feh
        ]}"
        "DISPLAY=:0"
        "XAUTHORITY=${config.home.homeDirectory}/.Xauthority"
      ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}