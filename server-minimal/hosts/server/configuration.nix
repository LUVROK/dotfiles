{ config, pkgs, ... }:

{
  imports = [ ];

  networking.hostName = "server";
  time.timeZone = "UTC";

  services.openssh.enable = true;

  users.users.root.initialPassword = "changeme";

  system.stateVersion = "24.05";
}
