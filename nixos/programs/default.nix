{ lib, config, ... }:

{
  imports = [
    ./st/st.nix
    ./steam.nix
    ./amnezia-vpn.nix
  ];
}