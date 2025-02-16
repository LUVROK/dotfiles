let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = ./dwmblocks;

  strictDeps = true;

  buildInputs = [ pkgs.xorg.libX11 ]
    ++ builtins.attrValues { inherit (pkgs.xorg) libxcb xcbutil; };

  nativeBuildInputs = [ pkgs.pkg-config ];

  makeFlags = [ "PREFIX=$(out)" ];

  # installPhase = ''
  #   mkdir -p $out/bin
  #   cp ./result/bin/dwmblocks $out/bin/dwmblocks
  # '';

  meta.mainProgram = "dwmblocks";
}
