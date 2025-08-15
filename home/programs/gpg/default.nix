{ config, lib, pkgs, ...}:

{
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 60;
    pinentry.package = pkgs.pinentry-rofi;
  };

  home.packages = with pkgs; [
    gnupg
  ];
}