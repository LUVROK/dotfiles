{ config, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    user = "dash";
    openDefaultPorts = true;

    dataDir = "/home/dash/HOME/wizzard";
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}
