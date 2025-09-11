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
      rev   = "c2a8fed053b01b81df02b2679dbadcf75a7822d4";
      hash  = "sha256-jmeOUKAs3gcEuiXqo6FclTGOMrWMcEQdGZlXFpdJjHs=";
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