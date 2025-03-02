{ config, lib, pkgs, ... }:

let
  yaml = pkgs.formats.yaml { };
in
{
  programs.udevil.enable = true;
  services.fstrim.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    sshfs
    exfat
    ntfs3g
    hfsprogs
  ];

  environment.etc."udevil/udevil.conf".text = ''
    allowed_users = *
    default_options = uid=dash,gid=dash,umask=0077
  '';

  environment.variables = {
    UDEVIL_CONF_PATH= "/etc/udevil/udevil.conf";
  };

  environment.etc."udiskie.yml".source = yaml.generate "udiskie.yml" {
    program_options = {
      automount = true;
      tray = false;
      notify = false;
    };
  };

  services.udev.extraRules = ''
    ENV{ID_FS_USAGE}=="filesystem", ENV{UDISKS_FILESYSTEM_SHARED}="1"
  '';
}
