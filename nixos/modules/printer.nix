{ lib, config, pkgs, ... }:

{
  hardware.sane.enable = true;
  # services.locate.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];
  environment.systemPackages = [ pkgs.hplipWithPlugin ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  services.printing = {
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
  };
}