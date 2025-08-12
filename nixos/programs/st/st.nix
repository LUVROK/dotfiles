{ config, pkgs, ... }:

let
  my-st = pkgs.st.overrideAttrs (oldAttrs: rec {
    pname = "st-custom";

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