{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [
      "splash"
      "quiet"
      "nvidia-drm.modeset=1" 
      "i915.force_probe=9a49"
      "usbcore.autosuspend=-1"
      "acpi_enforce_resources=lax"
      "acpi_rev_override=5" # If your BIOS artificially underestimates the ACPI to version less than 4.0, and the core is waiting for at least 4.0, if you see errors in dmesg about bios version
    ];

    kernelModules = [ 
      "kvm-intel"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "nouveau" ];

    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "xhci_hcd" "ehci_hcd" "sd_mod" "usbhid" ];
  };

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

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
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

  nixpkgs.config.nvidia.acceptLicense = true;
  time.hardwareClockInLocalTime = false;
}

