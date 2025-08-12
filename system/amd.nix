{ config, pkgs, lib, pkgs-pinned, ... }:

{
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "TearFree" "true"
      Option "DRI" "3"
      Option "Hotplug" "false"
    '';
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ 
      vaapiVdpau 
      libvdpau-va-gl 
      libva-utils
      libva
    ];
  };
  
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    amdgpu_top
    lm_sensors
    dmidecode
    vulkan-tools
  ];
}
