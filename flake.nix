{
  description = "My NixOS Config with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.dash = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configuration.nix
      ];
    };

    homeConfigurations."dash" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = ["${self}/./home/home.nix"];
      extraSpecialArgs = {inherit inputs;};
    };
  };
}