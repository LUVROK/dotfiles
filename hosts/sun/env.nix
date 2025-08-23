{ config, pkgs, lib, ... }:

{
  environment.etc."X11/xorg.conf.d/60-monitor.conf".text = ''
    
  '';
}
