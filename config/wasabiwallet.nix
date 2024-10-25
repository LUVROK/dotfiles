{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.wasabiwallet.overrideAttrs (oldAttrs: rec {
      postInstall = ''
        ${oldAttrs.postInstall or ""}
        wrapProgram $out/bin/wasabiwallet \
          --set QT_AUTO_SCREEN_SCALE_FACTOR 1.5
      '';
    }))
  ];
}