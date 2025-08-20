{ modulesPath, lib, ... }:

{
  system.stateVersion = "24.11";
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  systemd.network.enable = true;
  systemd.network.networks."10-ethernet" = {
    matchConfig.Type = "ether";
    networkConfig.DHCP = "yes";           # v4+v6
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  
  services.getty = {
    autologinUser = "root";
  };

  services.openssh = {
    enable = true;
    openFirewall = true;  
    settings = {
      PermitRootLogin = "prohibit-password"; # root по ключу ОК
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  systemd.network.networks."10-ens18" = {
    name = "ens18";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
  };

  networking = {
      firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKfVMnRoTEwUBqxcm6tzRTiFGZVafQ6dHr95HDM//Wk+ pawel.2020.navtop@gmail.com"
  ];

  environment.etc."nixos".source = ./.;
  system.activationScripts.copyConfig.text = ''
    rm -rf /root/nixos-config
    mkdir -p /root
    cp -rT ${./../..} /root/nixos-config
    chown -R root:root /root/nixos-config
  '';

  environment.systemPackages = with pkgs; [ vim htop curl wget ];
}
