{ lib, config, pkgs, ... }:

{
  networking = { 
    hostName = "barnard";

    networkmanager = {
      enable = false;
      # plugins = mkForce [];
      # dns = "systemd-resolved";
      # ethernet.macAddress = "random";
      # unmanaged = [
      #   "interface-name:br-*"
      #   "interface-name:virbr*"
      #   "interface-name:mullvad-vpn*"
      #   "type:bridge"
      # ];

      # wifi = {
      #   backend = "iwd";
      #   macAddress = "random"; # random mac address on every boot
      #   scanRandMacAddress = true; # random MAC during scanning
      # };
    };
  };

  systemd.network.wait-online.enable = false;
  systemd.services = {
    NetworkManager-wait-online.enable = false;
    systemd-networkd.stopIfChanged = false;
    systemd-resolved.stopIfChanged = false;
  };

  services.resolved.enable = true; # DNS Resolver
}