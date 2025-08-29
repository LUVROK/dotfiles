{ pkgs, config, lib, ... }:

with lib;

{
  options = {
    isHidpi = mkOption {
      type = types.bool;
      default = false;
    };
  }; 
}