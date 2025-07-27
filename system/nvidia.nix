{ config, pkgs, lib, pkgs-pinned, ... }:

{
  services.xserver = {
    videoDrivers = [ "modesetting" "nvidia" ];
  };
  
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ 
        intel-compute-runtime
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
      ]; 
    };

    nvidia={
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;

      prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    enableRedistributableFirmware = true;
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    intel-gpu-tools
    nvtopPackages.full
    
    mesa

    libinput-gestures

    nvidia-vaapi-driver
    vulkan-tools
    vulkan-helper
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vulkan-caps-viewer
    vulkan-volk
    
    cudatoolkit

    intel-compute-runtime
    intel-media-driver
    vaapiVdpau
    libvdpau-va-gl
    vaapiIntel

    inxi
  ];
}

