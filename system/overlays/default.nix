{ config, lib, pkgs, inputs, ... }: 

let
  dwm-flexipatch-rev = "10104fbc9ad3b7c68cfa38b7f387d83e82388ea6";
  dwm-flexipatch = pkgs.fetchFromGitHub {
    owner = "bakkeby";
    repo = "dwm-flexipatch";
    rev = dwm-flexipatch-rev;
    hash = "sha256-+6NrjxdbCnv9ZB0MvZ1+mWyxrEncQF14gijGPoWIhhY=";
  };
  
  isHidpi = config.isHidpi;
in
{
  imports = [ 
    ./extraShell.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        pname = "dwm-flexipatch";
        version = "flexipatch-${builtins.substring 0 7 dwm-flexipatch-rev}";
        src = dwm-flexipatch;

        # подмена конфигов до сборки
        postPatch = ''
          cp ${./dwm-flexipatch/config.h} config.h
          cp ${./dwm-flexipatch/patches.h} patches.h
          touch gruvbox.h
          cp ${./dwm-flexipatch/gruvbox.h} gruvbox.h
          cp ${if isHidpi then ./dwm-flexipatch/hidpi.h else ./dwm-flexipatch/lowdpi.h} dpi.h
        '';
      });
    })
    (final: prev: {
      # https://github.com/null-dev/firefox-profile-switcher-connector/issues/10#issuecomment-1238034441
      # don't work with my firefox configuration, that sad for now, i need figure it out that going on
      firefox-profile-switcher-connector = final.callPackage ./firefox-profile-switcher-connector.nix {};
    })
    (import ./mpv-config.nix)
    inputs.nur.overlays.default
  ];
}