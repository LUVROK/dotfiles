{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [ 
      # "quiet"
      # "splash"
      "nvidia-drm.modeset=1" 
      "i915.force_probe=9a49" 
      # "intel_iommu=on" 
      # "iommu=pt" 
      # "vfio-pci.ids=10de:25a0,10de:2291"
      # "vfio-pci.disable_idle_d3=1"
      # "vfio-pci.ids=8086:9a49" -- intel
    ];
    kernelModules = [ 
      "kvm-intel" 
      # "vhost_net" 
      # "vfio_iommu_type1" 
      # "vfio_pci" 
    ];

    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "nouveau" ];

    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
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

    xrandrHeads = [
      {
        output = "eDP-1-1";
        primary = true;
        monitorConfig = ''
          Option "PreferredMode" "3456x2160"
          Option "Position" "0 0"
          Option "DPI" "192"
        '';
      }
      {
        output = "HDMI-1";
        monitorConfig = ''
          Option "PreferredMode" "1920x1080"
          Option "Position" "3456 0"
          Option "DPI" "96"
        '';
      }
    ];
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
        # offload = { 
        #   enable = true;
        #   enableOffloadCmd=true;
        # };

        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  time.hardwareClockInLocalTime = true;
}

