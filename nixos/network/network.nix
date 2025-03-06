{ lib, config, pkgs, ... }:

{
  networking = { 
    # defaultGateway = { address = "192.168.0.92"; interface = "wlan0"; };

    # nameservers = [ "1.1.1.1" "8.8.8.8" ]; # DNS-servers

    # interfaces.wlan0.ipv4.addresses = [
    #   {
    #     address = "192.168.0.92"; # static ip
    #     prefixLength = 24;
    #   }
    # ];
    # useDHCP = false;
    # usePredictableInterfaceNames = true;
    
    networkmanager = {
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
  };

  services.resolved.enable = true; # DNS Resolver

  systemd = { 
    network.wait-online.enable = false;
    services = {
      NetworkManager-wait-online.enable = false;
      systemd-networkd.stopIfChanged = false;
      systemd-resolved.stopIfChanged = false;
    };
  };

  # services.resolved = {
  #   fallbackDns = [
  #     "1.1.1.1"
  #     "1.0.0.1"
  #     "2606:4700:4700::1111"
  #     "2606:4700:4700::1001"
  #   ];
  #   dnsovertls = "opportunistic";
  # };
}