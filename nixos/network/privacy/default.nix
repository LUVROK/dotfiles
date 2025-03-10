{ pkgs, ... }:

{ 
  imports = [ 
    # ./dnscrypt.nix 
    # ./frkn 
    # ./tcpcrypt.nix 
    ./tor.nix 
  ]; 

  environment.systemPackages = with pkgs; [
    # --- proxy ---
    orjail
    vopono
    proxychains
    firejail
    openvpn
    wireguard-tools
  ];
}