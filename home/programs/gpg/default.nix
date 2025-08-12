{pkgs, ...}:

{
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 10;
    pinentry.package = pkgs.pinentry-rofi;
  };

  home.packages = with pkgs; [
    gnupg
  ];
}