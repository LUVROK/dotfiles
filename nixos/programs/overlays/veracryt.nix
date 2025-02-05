{ pkgs, ... }:

let
  veracrypt = pkgs.veracrypt.overrideAttrs (oldAttrs: {
    pname = "veracrypt";
    version = "1.26.15";
    src = pkgs.fetchurl {
      url = "https://launchpad.net/veracrypt/trunk/1.26.15/+download/VeraCrypt_1.26.15_Source.tar.bz2";
      hash = "sha256-upcCUDDiG5sjMbfrCJcBFjwyr0t+BFNfM1uvjXSnSRY=";
    };
  });
in {
  environment.systemPackages = [ veracrypt ];
}
