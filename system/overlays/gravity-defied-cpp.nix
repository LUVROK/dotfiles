{ 
  lib,
  stdenv,
  fetchFromGitHub,
  makeDesktopItem,
  cmake,
  pkg-config,
  SDL2,
  SDL2_image,
  SDL2_ttf
}:

stdenv.mkDerivation rec {
  pname = "gravity-defied-cpp";
  version = "0.2";

  src = fetchFromGitHub {
    owner = "rgimad";
    repo = "gravity_defied_cpp";
    rev = "91bd283959b96a7ea07e1c4c0040460334c85458";
    hash = "sha256-ShJLUyTvT9WTB67KNVJlSLlRLrd+/rUb5IyJbVFR12Y=";
  };

  desktop = makeDesktopItem {
    desktopName = pname;
    name = pname;
    exec = "@out@/bin/${pname}";
    icon = pname;
    comment = "Rewrite Gravity Defied mobile game from Java to C++ & SDL";
    type = "Application";
    categories = [
      "Game"
    ];
    genericName = pname;
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ SDL2 SDL2_image SDL2_ttf ];

  # remove PKG_CONFIG_PATH override to let nixpkgs provide correct paths
  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace "unset(ENV{PKG_CONFIG_PATH})" ""
  '';

  # build optimized release binaries instead of debug
  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];

  installPhase = ''
    install -Dm755 GravityDefied $out/bin/gravity-defied-cpp

    install -Dm755 ${desktop}/share/applications/${pname}.desktop $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --subst-var out
  '';

  meta = with lib; {
    description = "Rewrite Gravity Defied mobile game from Java to C++ & SDL";
    homepage = "https://github.com/rgimad/gravity_defied_cpp";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
    mainProgram = "gravity-defied-cpp";
  };
}