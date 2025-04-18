{
  description = "NixOS + DWM Configuration (Flakes)";

  inputs = {
    nixpkgs-stable.url = github:NixOS/nixpkgs/nixos-24.11;
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nix-alien, nur, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.dash = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
        };
        inherit inputs system;
      };
      modules = [ 
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            pkgs-stable = import nixpkgs-stable {
              inherit system;
            };
            inherit inputs system;
          };
          home-manager.backupFileExtension = "backup";
          home-manager.users.dash = import "${self}/./home/home.nix";
        }
      ];
    };

    homeConfigurations."dash" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = ["${self}/./home/home.nix"];
      extraSpecialArgs = {inherit inputs nur;};
    };

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [ pkgs.firefox ];
    };

    # devShell.${system} = let
    #   pkgs = import nixpkgs-firefox {inherit system;};
    # in
    #   pkgs.mkShell {
    #     buildInputs = [
    #       pkgs.firefox
    #     ];
    #   };
  };
}