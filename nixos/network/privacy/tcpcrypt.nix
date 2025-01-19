{ lib, config, ... }:

{
  networking.tcpcrypt.enable = true;
  users = {
    groups.tcpcryptd = { };
    users.tcpcryptd = {
      group = "tcpcryptd";
      isSystemUser = true;
    };
  };
}