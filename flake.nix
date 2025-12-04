{
  description = "NixOS + DWM Configuration (Flakes)";

  inputs = {
    nixpkgs-pinned.url = "github:NixOS/nixpkgs/5593fccdd20bd2f47a60f55d799a99f36f90795d";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    disko.url = "github:nix-community/disko";

    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";

    textfox.url = "github:adriankarlen/textfox";
  };

  outputs = { self, nixpkgs, nixpkgs-pinned, home-manager, deploy-rs, disko, nur, zapret-discord-youtube, ... }@inputs: let
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
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        users.${username} = {
          imports = [ "${self}/home" ];
        };
        extraSpecialArgs = {
          inherit username inputs system;
          pkgs-pinned = import nixpkgs-pinned { inherit system; };
        };
      };
    };
  in {
    nixosConfigurations.barnard = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
        username = users.barnard.username;
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

        zapret-discord-youtube.nixosModules.default
        {
          services.zapret-discord-youtube = {
            enable = true;
            config = "general(ALT2)";  # Или любой конфиг из папки configs (general, general(ALT), general (SIMPLE FAKE) и т.д.)
          };
        }

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

        zapret-discord-youtube.nixosModules.default
        {
          services.zapret-discord-youtube = {
            enable = true;
            config = "general(ALT2)";  # Или любой конфиг из папки configs (general, general(ALT), general (SIMPLE FAKE) и т.д.)
          };
        }

        home-manager.nixosModules.home-manager
        (mkHMUser users.dash.username)  
        ({ config, pkgs, ... }: {
          boot.kernelPackages = pkgs.linuxPackages_latest;
        })
      ];
    };

    nixosConfigurations."sirius" = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
         username = users.sirius.username;
      };
      modules = [
        disko.nixosModules.disko
        ./hosts/sirius/sirius.nix
        ./hosts/sirius/disk-config.nix
      ];
    };

    nixosConfigurations."sirius-b" = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
         username = users.sirius.username;
      };
      modules = [
        disko.nixosModules.disko
        ./hosts/sirius-b/sirius.nix
        ./hosts/sirius-b/disk-config.nix
      ];
    };

    nixosConfigurations.WR7 = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
         username = users.WR7.username;
      };
      modules = [
        disko.nixosModules.disko
        ./hosts/sirius/sirius.nix
        ./hosts/WR7/disk-config.nix
      ];
    };

    packages.${system}.dwmblocks = pkgs.callPackage ./home/dwmblocks/dwmblocks-async/default.nix {};

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [ ];
    };
  };
}
