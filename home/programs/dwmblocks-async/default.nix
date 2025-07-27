{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";
  src = ./dwmblocks;
  strictDeps = true;
  buildInputs = [ pkgs.xorg.libX11 ] ++ builtins.attrValues { inherit (pkgs.xorg) libxcb xcbutil; };
  nativeBuildInputs = [ pkgs.pkg-config ];
  makeFlags = [ "PREFIX=$(out)" ];
  meta.mainProgram = "dwmblocks";
}