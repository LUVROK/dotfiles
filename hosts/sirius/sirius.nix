{ modulesPath, lib, pkgs, ... }:

# nix run --no-write-lock-file github:nix-community/nixos-anywhere -- --flake .#sirius root@45.137.99.130
# nixos-rebuild switch --flake .#sirius --target-host root@45.137.99.130 --sudo

{
  system.stateVersion = "24.11";
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_GB.UTF-8";

  services.getty.autologinUser = "root";

  networking.hostName = "sirius";
  networking.wireless.enable = false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  systemd.network.enable = true;
  systemd.network.wait-online.anyInterface = true;
  services.resolved.enable = true;
  networking.useNetworkd = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 443 ];
    allowPing = true;
  };

  systemd.network.networks."10-ens18" = {
    matchConfig.Name = "ens18";
    address = [ "45.137.99.130/24" ];
    routes = [ { routeConfig.Gateway = "45.137.99.1"; } ];
    dns = [ "8.8.8.8" "1.1.1.1" ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKfVMnRoTEwUBqxcm6tzRTiFGZVafQ6dHr95HDM//Wk+ pawel.2020.navtop@gmail.com"
  ];

  users.users.dash = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = "nopassword";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKfVMnRoTEwUBqxcm6tzRTiFGZVafQ6dHr95HDM//Wk+ pawel.2020.navtop@gmail.com"
    ];
  };

  environment.etc."nixos".source = ./.;
  system.activationScripts.copyConfig.text = ''
    rm -rf /root/nixos-config
    mkdir -p /root
    cp -rT ${./../..} /root/nixos-config
    chown -R root:root /root/nixos-config
  '';

  services.xray = {
    enable = true;
    settingsFile = ./xray.json; 
  };

  environment.systemPackages = with pkgs; [ vim htop curl wget git btop xray ];
}