{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "barnard";
    openDefaultPorts = true;

    dataDir = "/home/barnard/.config/syncthing";
    configDir = "/home/barnard/.config/syncthing";
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 7777 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 7777 ];

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}

