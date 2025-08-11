{pkgs, ...}:

{
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    pinentry.package = pkgs.pinentry-rofi;
  };

  home.packages = with pkgs; [
    gnupg
  ];
}