{ config, lib, pkgs, ... }:

{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  services.spice-vdagentd.enable = true;

  environment.systemPackages = with pkgs; [
    qemu_kvm
    qemu-utils
    bridge-utils
    spice
    spice-vdagent
  ];
}