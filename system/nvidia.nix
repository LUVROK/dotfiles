{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    kernelModules = [ "kvm-intel" "acpi_call" ];
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "nouveau" ];

    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ "i915" ];

    kernelParams = [ 
      # "nvidia-drm.modeset=1" 
      "modprobe.blacklist=nouveau" 
      "i915.force_probe=9a49"
    ];
  };

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = [ 
      # "intel"
      "modesetting" 
      "nvidia"
    ];
    
    dpi = 192;
    
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    windowManager.dwm = {
      enable = true;
    
      package = pkgs.dwm.overrideAttrs {
         src = ./dwm;
      };

      # package = pkgs.dwm.override {
        # patches = [
          # ./path/to/local.patch
          # (pkgs.fetchpatch {
          #   url = "https://dwm.suckless.org/patches/path/to/patch.diff";
          #   hash = "";
          # })
        # ];
      # };
    };

    config = lib.mkAfter ''
      Section "Device"
        Identifier "Intel Graphics"
        Driver "intel"
        BusID "PCI:0:2:0"
        Option          "TearFree" "true"
      EndSection

      Section "Monitor"
        Identifier "eDP-1-1"
        Option          "Enable" "true"
      EndSection

      Section "Screen"
        Identifier "Screen0"
        Device "Intel Graphics"
        Monitor "eDP-1-1"
      EndSection

      Section "ServerLayout"
        Identifier "Layout0"
        Screen 0 "Screen0" 0 0
        Option "Primary" "Screen0"
      EndSection

      Section "OutputClass"
        Identifier "Intel"
        MatchDriver "i915"
        Driver "modesetting"
        Option "PrimaryGPU" "true"
      EndSection
    '';
  };

  environment.systemPackages = with pkgs; [
    dmenu
    st  # простой терминал от suckless
    slock  # простой экранный блокировщик
  ];

  services.xserver.displayManager.sessionCommands = lib.mkAfter ''
    xrandr --setprovideroutputsource modesetting NVIDIA-G0
    xrandr --auto
  '';

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs;[ 
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ]; 
  };

  hardware.nvidia={
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    
    # nvidiaPersistenced = true;
    # forceFullCompositionPipeline = true;
  };

  # -- bumblebee --
  # nixpkgs.config.allowBroken = true;
  # hardware.bumblebee = {
    # enable = true;
    # driver = "nvidia";
    # pmMethod = "bbswitch";
  # };

  # hardware.nvidia.prime = {
    # offload = { 
      # enable = true;
      # enableOffloadCmd=true;
    # };
    # sync.enable = true;
    # intelBusId = "PCI:0:2:0";
    # nvidiaBusId = "PCI:1:0:0";
  # };

  # environment.variables = {
    # LIBVA_DRIVER_NAME = "intel";
    # __GLX_VENDOR_LIBRARY_NAME = "modesetting";
  # };

  programs.git = { enable = true; };
  time.hardwareClockInLocalTime = true;
}

