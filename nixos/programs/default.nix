{ lib, config, ... }:

{
  imports = [
    ./st/st.nix
    ./amnezia-vpn.nix
  ];
}