{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [ "nvidia-drm.modeset=1" "i915.force_probe=9a49" ];
    kernelModules = [ "kvm-intel" ];
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
    
    config = ''
      Section "ServerLayout"
        Identifier "layout"
        Screen 0 "intel"
        Inactive "nvidia"
      EndSection
    '';

    xrandrHeads = [
      {
        output = "eDP-1-1";
        primary = true;
        monitorConfig = ''
          Option "PreferredMode" "3456x2160"
          Option "Position" "0 0"
        '';
      }
      {
        output = "HDMI-1";
        monitorConfig = ''
          Option "PreferredMode" "1920x1080"
          Option "Position" "3456 0"
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

    xorg.xorgserver
    xorg.xf86inputlibinput
    xorg.xf86videointel
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs;[ 
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
      vaapiIntel
    ]; 
  };

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  hardware.nvidia={
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.nvidia.prime = {
    offload = { 
      enable = true;
      enableOffloadCmd=true;
    };

    # sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };


  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME="mesa";
  };

  programs.git = { enable = true; };
  time.hardwareClockInLocalTime = true;
}

