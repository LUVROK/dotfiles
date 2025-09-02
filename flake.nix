{
  description = "NixOS + DWM Configuration (Flakes)";

  inputs = {
    nixpkgs-stable.url = github:NixOS/nixpkgs/nixos-24.11;
    nixpkgs-pinned.url = "github:NixOS/nixpkgs/5593fccdd20bd2f47a60f55d799a99f36f90795d";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    disko.url = "github:nix-community/disko";

    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-pinned, nixpkgs-stable, home-manager, deploy-rs, disko, nur, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowBroken = false;
        allowUnfree = true;
        allowInsecure = false;
      };
    };

    users  = import ./profiles/users.nix;
    dwmblocks = self.packages.${system}.dwmblocks;

    mkHMUser = username: { ... }: {
      home-manager = {
        useGlobalPkgs = false;
        useUserPackages = true;
        backupFileExtension = "backup";
        users.${username} = {
          imports = [ "${self}/home" ];
        };
        extraSpecialArgs = {
          inherit username inputs system;
          pkgs-stable = import nixpkgs-stable { inherit system; };
          pkgs-pinned = import nixpkgs-pinned { inherit system; };
        };
      };
    };
  in {
    nixosConfigurations.barnard = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
        username = users.barnard.username;
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
        ./base.nix
        ./hosts/barnard
        home-manager.nixosModules.home-manager
        (mkHMUser users.barnard.username)
        ({ config, pkgs, ... }: {
          boot.kernelPackages = pkgs.linuxPackages_latest;
        })
      ];
    };

    nixosConfigurations.dash = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
        username = users.dash.username;
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
        ./base.nix
        ./hosts/sun
        home-manager.nixosModules.home-manager
        (mkHMUser users.dash.username)  
        ({ config, pkgs, ... }: {
          boot.kernelPackages = pkgs.linuxPackages_latest;
        })
      ];
    };

    nixosConfigurations.sirius = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      modules = [
        disko.nixosModules.disko
        ./hosts/sirius/sirius.nix
        ./hosts/sirius/disk-config.nix
      ];
    };

    packages.${system}.dwmblocks = pkgs.callPackage ./home/dwmblocks/dwmblocks-async/default.nix {};
    
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [ ];
    };
  };
}