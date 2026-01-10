{ config, lib, pkgs, inputs, ... }:

let
  dwm = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "dwm";
    rev = "489626c47709cb4865b213f0b9400ae7cf321e8f";
    hash = "sha256-txwe60vlc++2SwBV8vsfcOdSnUt3uVaEj9SYqZk+DW0=";
  };
  st = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "st";
    rev = "137e80e557b15b475f3a0014637df47bcdcbf71d";
    hash = "sha256-a8xrU/JDREtLi+e2OSL4Z0+0MqjQ9WnPmnQO4YUvcFQ=";
  };
in
{
  imports = [
    ./extraShell.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        pname = "dwm";
        version = "489626c47709cb4865b213f0b9400ae7cf321e8f";
        src = dwm;
      });
    })
    (self: super: {
      ranger = super.ranger.overrideAttrs (
        final: prev: {
          postPatch = ''
                    substituteInPlace ranger/data/scope.sh \
          --replace "# video/*)" "video/*)" \
          --replace "#     # Get frame 10% into video" "    # Get frame 10% into video" \
          --replace "#     ffmpegthumbnailer -i \"\''${FILE_PATH}\" -o \"\''${IMAGE_CACHE_PATH}\" -s 0 && exit 6" \
              '    ffmpegthumbnailer -i "''${FILE_PATH}" -o "''${IMAGE_CACHE_PATH}" -s 0 && exit 6
                    exit 1;;'
          '';
        }
      );
    })
    (final: prev: {
      st = prev.st.overrideAttrs (old: {
        pname = "st";
        version = "137e80e557b15b475f3a0014637df47bcdcbf71d";
        src = st;
      });
    })
    (import ./mpv-config.nix)
    inputs.nur.overlays.default
  ];
}
