{ config, pkgs, lib, pkgs-pinned, ... }:

{
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.vaapiVdpau pkgs.libvdpau-va-gl ];
  };
  
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    radeontop
    amdgpu_top
    lm_sensors
    dmidecode
    libva-utils
    vulkan-tools
  ];
}
