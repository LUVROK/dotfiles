{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "ssh" ''
      TERM=xterm ${pkgs.openssh}/bin/ssh "$@"
    '') # TODO: alias probably
  ];
}