{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.amnezia-vpn.enable = true;

  environment.systemPackages = [ pkgs.amnezia-vpn ];
  services.dbus.packages = [ pkgs.amnezia-vpn ];
  services.resolved.enable = true;

  systemd = {
    packages = [ pkgs.amnezia-vpn ];
    services."AmneziaVPN".wantedBy = [ "multi-user.target" ];
  };

  meta.maintainers = with lib.maintainers; [ sund3RRR ];
}