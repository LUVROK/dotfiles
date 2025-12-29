{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    libva-utils
    intel-gpu-tools
    nvtopPackages.full

    mesa
    driversi686Linux.mesa

    libinput-gestures

    nvidia-vaapi-driver
    vulkan-tools

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
        libva-vdpau-driver
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
