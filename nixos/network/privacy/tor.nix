{ config, lib, pkgs, ... }:

{
  services.tor = {
    enable = true;
    # client.enable = true;
    # client.dns.enable = true;
    # client.transparentProxy.enable = true;
    # client.socksListenAddress = { addr = "0.0.0.0"; port = 9050; };
    # controlSocket.enable = true;
    # relay.enable = true;
    # relay.role = "relay";
    # settings = {
    #   ORPort = 143;
    #   ControlPort = [ 9051 ];
    # };
  };
}