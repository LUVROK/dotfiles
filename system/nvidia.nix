{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = false;

    videoDrivers = [ 
      "nvidia"
      "modesetting" 
    ];
    
    dpi = 192;
    upscaleDefaultCursor = true;
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    intel-gpu-tools
    nvtopPackages.full
    
    mesa
    mesa.drivers
    driversi686Linux.mesa
    vulkan-helper

    picom
    libinput-gestures

    nvidia-vaapi-driver
    vulkan-tools
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vulkan-caps-viewer
    cudatoolkit

    intel-compute-runtime
    intel-media-driver
    vaapiVdpau
    libvdpau-va-gl
    vaapiIntel
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ 
        intel-compute-runtime
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
        vaapiIntel
        nvidia-vaapi-driver
      ]; 
    };

    nvidia={
      modesetting.enable = true;
      powerManagement = {
        enable = true;
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
  };
}

