{ pkgs, ... }:

let
  unstoppableSwap = pkgs.writeShellScriptBin "unstoppableSwap" ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libxcrypt-legacy}/lib
    export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
    export DOTNET_SYSTEM_GLOBALIZATION_PREDEFINED_CULTURES_ONLY=false
    export SSL_CERT_DIR=${pkgs.cacert}/etc/ssl/certs
    export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt

    echo  ${pkgs.cacert}/etc/ssl/certs
    #env
    #zsh
    exec ${pkgs.appimage-run}/bin/appimage-run ~/HOME/wizzard/apps/UnstoppableSwap-0.6.4.AppImage
  '';

in { environment.systemPackages = [ unstoppableSwap ]; }