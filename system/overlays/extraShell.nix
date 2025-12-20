{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "ssh" ''
      TERM=xterm ${pkgs.openssh}/bin/ssh "$@"
    '')
  ];
}
