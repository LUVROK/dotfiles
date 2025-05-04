{ config, pkgs, ... }:

{
  imports = [
    # ./disko.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings.experimental-features = [ "nix-command" ];

  networking = {
    hostName = "wolf";
    firewall.enable = true;
  };

  time.timeZone = "Europe/Bucharest";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2/7wyLk5dWcldqG9IikXQfpE1Qc/3qPUzCJ76MYvMG"
      ];
    };
    # nixos = { ... };
  };

  # environment.systemPackages = with pkgs; [
  #   git
  #   curl
  #   vim # или neovim
  # ];

  system.stateVersion = "24.05";
}
