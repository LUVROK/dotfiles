{ lib, config, ... }:

{
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings.AutoConnect = true;
      General = {
        AddressRandomization = "network";
        AddressRandomizationRange = "full";
        EnableNetworkConfiguration = true;
        RoamRetryInterval = 10;
      };

      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300; # priority wifi over ethernet
      };
    };
  };
}