{ lib, config, pkgs, ... }:

{
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      ethernet.macAddress = "random";
      unmanaged = [
        "interface-name:br-*"
        "interface-name:rndis*"
        "interface-name:docker*"
        "interface-name:virbr*"
        "interface-name:vboxnet*"
        "interface-name:waydroid*"
        "interface-name:mullvad-vpn*"
        "type:bridge"
      ];

      wifi = {
        backend = "iwd";
        macAddress = "random"; # random mac address on every boot
        scanRandMacAddress = true; # random MAC during scanning
      };
    };
}