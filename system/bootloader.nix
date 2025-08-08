{ config, pkgs, lib, pkgs-pinned, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/efi";
      };
      
      # grub = {
      #   enable = true;
      #   efiSupport = true;

      #   efiInstallAsRemovable = true;
      #   device = "nodev";
      #   useOSProber = true;
      #   timeoutStyle = "menu";
      #   splashImage = lib.mkForce null;
      # };

      # timeout = 4;
    };

    kernelParams = [
      "quiet"
      # "splash"
      # "boot.shell_on_fail"
      # "loglevel=3"
      # "rd.systemd.show_status=false"
      # "rd.udev.log_level=3"
      # "udev.log_priority=3"

      # "drm.debug=0x1e"      # включает подробный вывод KMS
      # "log_buf_len=1M"      # увеличивает буфер логов ядра
      # "printk.time=1"       # префикс времени в dmesg
    ];

    # kernelModules = [ 
      
    # ];

    # blacklistedKernelModules = [ ];

    kernelPackages = pkgs.linuxPackages_latest; # TODO:

    # initrd.availableKernelModules = [ 
    #   "nvme"
    #   "xhci_pci" 
    #   "thunderbolt"
    #   "usb_storage"
    #   "xhci_hcd" 
    #   "ehci_hcd"
    #   "sd_mod" 
    #   "usbhid"
    # ];

    # initrd.systemd.enable = true;
    # initrd.verbose = false;
    # consoleLogLevel = 0;
  };
}

