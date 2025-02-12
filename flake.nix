{
  description = "My NixOS Config with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations.dash = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configuration.nix
      ];
    };
    
    homeConfigurations = (
      import ./home {
        inherit system home-manager;
        username = "dash";
        pkgs = import nixpkgs {
          inherit system;
        };
      }
    );

    # devShell.${system} = let
    #   overlays = [nur.overlays.default];
    #   pkgs = import nixpkgs {inherit system overlays;};
    # in
    #   pkgs.mkShell {
    #     buildInputs = [
    #       pkgs.nur.repos.rycee.mozilla-addons-to-nix
    #     ];
    #   };
  };
}