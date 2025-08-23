{ config, pkgs, username, ... }:

{
  services.syncthing = {
    enable = true;
    user = "${username}";
    openDefaultPorts = true;

    dataDir = "/home/${username}/.config/syncthing";
    configDir = "/home/${username}/.config/syncthing";
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 7777 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 7777 ];

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}

