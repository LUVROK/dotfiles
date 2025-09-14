{ config, pkgs, lib, pkgs-pinned, ... }:

{
  services.xserver = {
    dpi = 112;  
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "TearFree" "true"
      Option "DRI" "3"
    '';
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    amdgpu_top
    lm_sensors
    dmidecode
    vulkan-tools
    vaapiVdpau 
    libvdpau-va-gl 
    libva-utils
    libva
    mangohud
  ];

  environment.etc."X11/xorg.conf.d/10-amdgpu.conf".text = ''
    Section "Device"
        Identifier "AMD"
        Driver "amdgpu"
        Option "TearFree" "on"
        Option "Hotplug" "false"
    EndSection
  '';

  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
  };
}
