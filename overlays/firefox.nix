{ inputs, pkgs, ... }:

{
  inputs.nixpkgs-firefox.url = "github:NixOS/nixpkgs/5593fccdd20bd2f47a60f55d799a99f36f90795d";

  outputs = { self, nixpkgs-firefox, ... }: 
  let
    pkgs = import nixpkgs-firefox { system = "x86_64-linux"; };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [ pkgs.firefox ];
    };
  };
}
