{ lib, config, ... }:

{
  # use iwd instead of wpa_supplicant
  # networking.wireless.enable = false;

  # networking.networkmanager.enable = false;

  # Use iwd instead of wpa_supplicant. It has a user friendly CLI
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Network = {
        EnableIPv6 = true;
        # RoutePriorityOffset = 300;
      };
      Settings.AutoConnect = true;
    };
  };
}


