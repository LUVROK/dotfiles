{ lib, config, ... }:

{
  imports = [
    # ./security
    ./privacy
    # ./fast-tcp.nix
    # ./systemd.nix
    # ./openssh.nix
    ./network.nix
    ./wireless.nix
  ];

  networking = {
    useNetworkd = true; # DHCP analog
    useDHCP = false;
    usePredictableInterfaceNames = true;
  };
}