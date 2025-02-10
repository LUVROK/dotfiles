{ config, lib, pkgs, ... }:

{
  imports = [
    ./profiles.nix
  ];

  config = {
    programs.autorandr.enable = true;
    # services.autorandr.enable = true;

    programs.autorandr.hooks.postswitch.notify = ''
      ${pkgs.libnotify}/bin/notify-send "Display profile changed" $(${pkgs.autorandr}/bin/autorandr --detected)
    '';
    home.packages = [ pkgs.arandr ];

    systemd.user.services.autorandr = {
      Unit = {
        Description = "autorandr dynamic output configuration";
        PartOf = ["graphical-session.target"];
        Requires = ["graphical-session.target"];
        After = ["graphical-session.target" "dwmblocks.service"];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.autorandr}/bin/autorandr --change --default laptop-monitor";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
