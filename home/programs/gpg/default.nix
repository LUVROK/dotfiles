{ config, lib, pkgs, ...}:

{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 60;
    pinentry.package = pkgs.pinentry-rofi;
  };
}
