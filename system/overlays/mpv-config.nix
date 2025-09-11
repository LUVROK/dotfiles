let
  my-mpv = ./mpv.conf;  # путь к твоему файлу
in
self: super: {
  mpv-config = super.stdenvNoCC.mkDerivation {
    pname = "mpv-config";
    version = "fork-pinned-11.09.2025";
    src = super.fetchFromGitHub {
      owner = "LUVROK";
      repo  = "mpv-config";
      rev   = "4a01da450ef170c86a379ac9b19d20ee6df8353b";
      hash  = "sha256-cNsg2RpTT7252/z/8bZcY5RrRMG2v9QI6mqay9AHRU8=";
    };
    installPhase = ''
      set -euo pipefail
      mkdir -p "$out"
      cp -r "$src/portable_config/"* "$out/"
      rm -f "$out/mpv.conf"
      
      install -Dm644 ${my-mpv} "$out/mpv.conf"
    '';
  };
}