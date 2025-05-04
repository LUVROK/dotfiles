{
  description = "NixOS + DWM Configuration (Flakes)";

  inputs = {
    nixpkgs-stable.url = github:NixOS/nixpkgs/nixos-24.11;
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nix-alien.url = "github:thiagokokada/nix-alien";

    minecraft-plymouth-theme.url = "github:nikp123/minecraft-plymouth-theme";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nix-alien, nur, disko, minecraft-plymouth-theme, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        overlays = [ 
          minecraft-plymouth-theme.overlay
          (final: prev: {
            intel-vaapi-driver = prev.intel-vaapi-driver.override {
              enableHybridCodec = true;
            };
          })
        ];
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

            nvidia.acceptLicense = true;
            # packageOverrides = pkgs: {
            #   intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
            # };
          };
      };
  in {
    nixosConfigurations.dash = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
        };
        inherit inputs system;
      };
      modules = [ 
        ./configuration.nix
        home-manager.nixosModules.home-manager
        inputs.minegrub-theme.nixosModules.default
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

    nixosConfigurations.wolf = nixpkgs.lib.nixosSystem {      
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        ./server-minimal/hosts/server/disko.nix
        ./server-minimal/hosts/server/configuration.nix
      ];
    };

    # homeConfigurations."dash" = home-manager.lib.homeManagerConfiguration {
    #   inherit pkgs;
    #   modules = ["${self}/./home/home.nix"];
    #   extraSpecialArgs = {inherit inputs nur;};
    # };

    # devShells.x86_64-linux.default = pkgs.mkShell {
    #   buildInputs = [ pkgs.firefox ];
    # };

    # packages.${system}.Script =
    #     self.nixosConfigurations.wolf.config.system.build.toplevel;

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