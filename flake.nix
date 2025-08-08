{
  description = "NixOS + DWM Configuration (Flakes)";

  inputs = {
    nixpkgs-stable.url = github:NixOS/nixpkgs/nixos-24.11;
    nixpkgs-pinned.url = "github:NixOS/nixpkgs/5593fccdd20bd2f47a60f55d799a99f36f90795d";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-pinned, nixpkgs-stable, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowBroken = true;
        allowUnfree = true;
        allowInsecure = true;
        permittedInsecurePackages = [
          "dotnet-runtime-6.0.36"
          "aspnetcore-runtime-6.0.36"
          "aspnetcore-runtime-wrapped-6.0.36"
          "dotnet-sdk-6.0.428"
          "dotnet-sdk-wrapped-6.0.428"
          "rider"
          "dotnet-sdk-7.0.410"
          "dotenv6"
        ];
      };
    };
  in {
    nixosConfigurations.barnard = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
        };
        pkgs-pinned = import nixpkgs-pinned {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        inherit inputs system;
      };
      modules = [ 
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = false;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.barnard = import "${self}/./home/home.nix";
            extraSpecialArgs = {
              pkgs-stable = import nixpkgs-stable {
                inherit system;
              };
              pkgs-pinned = import nixpkgs-pinned {
                inherit system;
              };
              inherit inputs system;
            };
          };
        }
        ({ config, pkgs, ... }: {
          environment.systemPackages = [
            self.packages.${system}.dwmblocks
          ];
        })
      ];
    };

    packages.${system}.dwmblocks = pkgs.callPackage ./home/dwmblocks-async/default.nix {};
    
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        # pkgs.stdenv
        # pkgs.xorg.libX11
        # pkgs.xorg.libxcb
        # pkgs.xorg.xcbutil
        # pkgs.pkg-config
      ];
    };
  };
}