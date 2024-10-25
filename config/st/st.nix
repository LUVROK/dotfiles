{ config, pkgs, ... }:

let
  my-st = pkgs.st.overrideAttrs (oldAttrs: rec {
    pname = "st-custom";
    version = "0.9.2";

    preConfigure = ''
      cp ${./st-config.h} config.h
    '';
  });
in
{
  environment.systemPackages = with pkgs; [
    my-st
  ];
}