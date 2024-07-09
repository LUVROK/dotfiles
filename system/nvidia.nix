{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # extraModulePackages = with config.boot.kernelPackages; [ acpi_call bbswitch ];
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "nouveau" ];
    # initrd.kernelModules = [ "nvidia" "modesetting" ];
  };

  services.xserver.videoDrivers = [
    # "modesetting" 
    "intel"
    "nvidia"
    # "nouveau"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs;[ 
      intel-media-driver
      (vaapiIntel.override { enableHybridCodec = true; })
      vaapiVdpau
      libvdpau-va-gl
      # config.boot.kernelPackages.nvidia_x11
    ]; 
  };

  hardware.nvidia={
    modesetting.enable = true;
    powerManagement.enable = false;
    # powerManagement.finegrained = false;
    
    # open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    # package = pkgs.linuxPackages.nvidia_x11;
    
    nvidiaPersistenced = true;
    # forceFullCompositionPipeline = true;
  };

  # environment.systemPackages = [ pkgs.linuxPackages.nvidia_x11 ];

  # hardware.nvidia.prime = {
    # offload = { 
      # enable = true;
      # enableOffloadCmd=true;
    # };
    # sync.enable = true;
    # intelBusId = "PCI:0:2:0";
    # nvidiaBusId = "PCI:1:0:0";
  # };

  environment.variables = {
    # LIBVA_DRIVER_NAME = "i965"; # i965
    __GLX_VENDOR_LIBRARY_NAME = "intel";

    # LIBVA_DRIVER_NAME = "i965";  # или "modesetting"
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    LIBVA_DRIVER_NAME = "intel";
    # __GLX_VENDOR_LIBRARY_NAME = "intel";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # __NV_PRIME_RENDER_OFFLOAD = "1";
    # __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    # __VK_LAYER_NV_optimus = "NVIDIA_only";
    
    # MESA_LOADER_DRIVER_OVERRIDE="iris";
    # __GL_SYNC_TO_VBLANK="1";
    # __GL_SYNC_DISPLAY_DEVICE="eDP-1-1";
    # __VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE="eDP-1-1";
    # INTEL_NO_TEAR = "1";

    # CLUTTER_PAINT = "disable-clipped-redraws:disable-culling";
    # CLUTTER_VBLANK="True";
  };

  programs.git = { enable = true; };
  time.hardwareClockInLocalTime = true;
}

