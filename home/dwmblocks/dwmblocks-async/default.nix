{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = pkgs.fetchFromGitHub {
    owner = "UtkarshVerma";        # укажи владельца
    repo  = "dwmblocks-async";         # и репозиторий
    rev   = "fe538a7a2fc52e991a553bd76719735141658844";# pin на коммит/тег
    hash  = "sha256-rFzgCU2wv5w7dc1xVZwX6dCFOAqM1DVK/aoFh1mwDSs="; # заполни хэш
  };

  postPatch = ''
    cp -f ${./config.h} config.h
  '';

  # src = ./dwmblocks;
  strictDeps = true;
  buildInputs = [ pkgs.xorg.libX11 ] ++ builtins.attrValues { inherit (pkgs.xorg) libxcb xcbutil; };
  nativeBuildInputs = [ pkgs.pkg-config ];
  makeFlags = [ "PREFIX=$(out)" ];
  meta.mainProgram = "dwmblocks";
}