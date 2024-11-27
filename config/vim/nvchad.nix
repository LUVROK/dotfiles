{ lib, stdenv, fetchFromGitHub }:

let
  custom = ./custom;
in
{
nvchad = stdenv.mkDerivation rec {
  pname = "nvchad";
  version = "";
  dontBuild = true;

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "starter";
    rev = "70f66adb594e6854eff5d39ccc13030559a75ae6";
    sha256 = "sha256-3S7yQqNpSyvGl5SVaY2FJvPI6bX2XNftWx1tDEypISc=";
  };

  installPhase = ''
    mkdir $out
    cp -R * "$out/"
    mkdir -p "$out/lua/custom"
  '';
  postFixup = ''
    cp -r ${custom}/* "$out"
  '';

  meta = with lib; {
    description = "NvChad";
    homepage = "https://github.com/NvChad/NvChad";
    platforms = platforms.all;
    maintainers = [];
    license = licenses.gpl3;
  };
};
}