{ config, lib, pkgs, ... }:

{
  config = {
    services.tor = {
      enable = true;
      client.enable = true;
      client.dns.enable = true;
    };

    environment.variables = {
      TOR_SOCKS_PORT = "9050";
    };
  };
}