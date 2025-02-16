{ lib, config, ... }:

{
  imports = [
    ./systemd-network.nix
    ./pipewire.nix
    ./syncthing.nix
    ./display-managers
  ];

  # users.users.jellyfin.extraGroups = [
  #   "video"
  #   "render"
  # ];

  # services.jellyfin = {
  #   enable = true;
  #   # cacheDir = "/var/cache/jellyfin";
  #   # dataDir  = "/var/lib/jellyfin";
  # };
}