{ config, pkgs, lib, pkgs-pinned, ... }:

{
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "TearFree" "true"
      Option "DRI" "3"
    '';
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.vaapiVdpau pkgs.libvdpau-va-gl ];
  };
  
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    amdgpu_top
    lm_sensors
    dmidecode
    libva-utils
    vulkan-tools
  ];
}
