{ lib, config, ... }:

{
  imports = [
    ./network
    ./services
    ./modules
    ./programs
  ];
}