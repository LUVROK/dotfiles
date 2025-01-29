{ lib, config, ... }:

{
  imports = [
    # ./security
    ./privacy
    # ./fast-tcp.nix
    # ./systemd.nix
    # ./openssh.nix
    ./networkmanager.nix
    ./wireless.nix
  ];

  networking = {
    hostName = "nixos";
    useNetworkd = lib.mkForce true; # DHCP analog
    useDHCP = lib.mkForce false;
    usePredictableInterfaceNames = lib.mkDefault true;
    hostId = builtins.substring 0 8
      (builtins.hashString "md5" config.networking.hostName);
  };
}