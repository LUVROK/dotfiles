{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = pkgs.fetchFromGitHub {
    owner = "UtkarshVerma";
    repo  = "dwmblocks-async";
    rev   = "fe538a7a2fc52e991a553bd76719735141658844";
    hash  = "sha256-rFzgCU2wv5w7dc1xVZwX6dCFOAqM1DVK/aoFh1mwDSs=";
  };

  postPatch = ''
    cp -f ${./config.h} config.h
  '';

  strictDeps = true;
  buildInputs = [ pkgs.xorg.libX11 ] ++ builtins.attrValues { inherit (pkgs.xorg) libxcb xcbutil; };
  nativeBuildInputs = [ pkgs.pkg-config ];
  makeFlags = [ "PREFIX=$(out)" ];
  meta.mainProgram = "dwmblocks";
}
