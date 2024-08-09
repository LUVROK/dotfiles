{ config, lib, pkgs, ... }:

{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings.mysqld = {
      bind-address = "127.0.0.1";
    };
    ensureUsers = [{
      name = "root";
    }];
  };
  
  environment.systemPackages = with pkgs; [
    mysql
  ];
}
