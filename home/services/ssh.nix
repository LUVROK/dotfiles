{ pkgs, lib, config, agenix, ... }:

{
  programs.ssh.knownHosts = {
   "yggdrasil-ed25519" = {
      hostNames = [ "192.168.3.20" "yggdrasil.rumahindo.lan" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEPGfcCOn0yr2dLWpEInCsW7aMrT3M1XxUcJmZObtWwT";
    };
    "yggdrasil-rsa" = {
      hostNames = [ "192.168.3.20" "yggdrasil.rumahindo.lan" ];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3e6cg9jlNkStLqIZltNdcEtM5fLnbBzvcHRIrVbueQo5XVEYjLjfY0vLqvsMokGk1K539tBE7LzwGmrh8PL/ZR83Bj2Kgz+uUauBnUufA3C0uJFyOjcsx3vhbry12srOEupnJPeevlSrLBUNpLElHjhPsEknjljM7ATxGmy/teYziPtkdO5DUPgTM50QA4q7LtEV3jkmUpTJB2IuUa8hkl9++DYq42QE/8hcizLVkgLehaMrhmDz7U9za0qQEy3AyOiKSUSuskQ1iVGt7uQH4eST6X8LsfrRVnHSRgJTekJSoIq3ONqqFdq5I2GArjMQ+EJB1g0whNcmNKDYdieV0V+A3LJluVJ1R9SdIhDHh2ZWQjkgj4Uo7o8N1bFNlmJgerMb5vlNg8bTXBDp1H/jRx8Y6TJNIIW/P6xdk8+jEK05mCn1hpup6q17oayTCEHj6w76njA78bLU/hQ6ZeI2nCrr//MR8ZWFQyF7HGqHI1pPAkl+vyzwE6HdBrh8/h9foU42W2hOAQJhOiKlU66QPj7Boapumawkxlh+iHsO+M8C6bSBoWWMjFapNYWm5/1q+2tbrpgD8uDEPn5X9tXcnt3g4ZOJbPiw3u7eHNz7P41VTxXj0tsSx7ehHX/PHjsgZCh4PEqbmwbIPjnJk7HD6uYt6YfI03+lKbtr5MWso7Q==";
    };
    "yggdrasil-cloudflare" = {
      hostNames = [ "192.168.3.20" "yggdrasil.rumahindo.lan" ];
      publicKey= "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFrAGLsDAdnZ9tQ2RHlwMxhLQJIUeslHpyN2w4TiKfvv";
    };
  };
}