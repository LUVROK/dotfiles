{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [
      "nvidia-drm.modeset=1" 
      "i915.force_probe=9a49"
    ];
    kernelModules = [ 
      "kvm-intel"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "nouveau" ];

    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "xhci_hcd" "ehci_hcd" "sd_mod" "usbhid" ];
  };

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;

    videoDrivers = [ 
      "modesetting" 
      "nvidia"
    ];
    
    dpi = 192;
    upscaleDefaultCursor = true;
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    intel-gpu-tools
    nvtopPackages.full
    vulkan-tools
    
    mesa
    mesa.drivers
    driversi686Linux.mesa
    vulkan-helper

    picom
    libinput-gestures
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  hardware = {
    openrazer.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs;[ 
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
        vaapiIntel
      ]; 
    };

    nvidia={
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;

      prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  time.hardwareClockInLocalTime = true;
}

