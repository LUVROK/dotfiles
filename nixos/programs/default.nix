{ lib, config, ... }:

{
  imports = [
    ./st/st.nix
    ./amnezia-vpn.nix
    ./overlays
    ./steam.nix
  ];
}
