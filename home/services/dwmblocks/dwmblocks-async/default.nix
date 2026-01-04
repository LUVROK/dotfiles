{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = pkgs.fetchFromGitHub {
    owner = "UtkarshVerma";
    repo  = "dwmblocks-async";
    rev   = "38cadc6427db51700b3add3c356da5d41b36f8e0";
    hash  = "sha256-E3Jk+Cpcvo7/ePEdi09jInDB3JqLwN+ZHtutk3nmmhM=";
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
