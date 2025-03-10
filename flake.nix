{
  description = "NixOS + DWM Configuration (Flakes)";

  inputs = {
    nixpkgs-stable.url = github:NixOS/nixpkgs/nixos-24.11;
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.dash = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
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
    
    # homeConfigurations = (
    #   import ./home/home.nix {
    #     inherit system home-manager;
    #     username = "dash";
    #     pkgs = import nixpkgs {
    #       inherit system;
    #     };
    #   }
    # );

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