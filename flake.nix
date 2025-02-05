{
  # nix flake update
  inputs = {
    # nix flake lock --update-input <input>
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs-stable, nixpkgs, home-manager, ... }:
    let
      nix-config-module = {
        nix = {
          nixPath = [ "nixpkgs=${nixpkgs-stable}" "unstable=${nixpkgs-unstable}" ];
          registry = {
            # nixpkgs.flake = nixpkgs-stable; is already set
            unstable.flake = nixpkgs-unstable;
          };
        };
      };
      nixpkgs-overlays-module = {
        nixpkgs.overlays = [
          (final: prev: {
            # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/3
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            # https://github.com/NixOS/nixpkgs/issues/376743
            veracrypt = prev.veracrypt.overrideAttrs (finalAttrs: prevAttrs: rec {
              pname = "veracrypt";
              version = "1.26.15";
              src = prev.fetchurl {
                url = "https://launchpad.net/veracrypt/trunk/${version}/+download/VeraCrypt_${version}_Source.tar.bz2";
                hash = "sha256-upcCUDDiG5sjMbfrCJcBFjwyr0t+BFNfM1uvjXSnSRY=";
              };
            });
          })
        ];
      };
      home-manager-config-module.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.evenbrenden = import ./home/home.nix;
      };
      common-modules =
        [ nix-config-module nixpkgs-overlays-module home-manager.nixosModules.home-manager home-manager-config-module ];
      system = "x86_64-linux";
}