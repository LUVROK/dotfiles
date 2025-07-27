{ config, pkgs, lib, pkgs-pinned, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/efi";
      };
      
      grub = {
        enable = true;
        efiSupport = true;

        efiInstallAsRemovable = true;
        device = "nodev";
        useOSProber = true;
        timeoutStyle = "menu";
        splashImage = lib.mkForce null;
      };

      timeout = 4;
    };

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      "drm.debug=0x1e"      # включает подробный вывод KMS
      "log_buf_len=1M"      # увеличивает буфер логов ядра
      "printk.time=1"       # префикс времени в dmesg
      
      "nvidia-drm.fbdev=0"
      "nvidia-drm.modeset=1" 

      "i915.enable_psr=0" # disables a power saving feature that can cause flickering
      "i915.enable_rc6=0"
      "i915.force_probe=9a49"

      # "usbcore.autosuspend=-1"
      # "acpi_enforce_resources=lax"
      # "acpi_rev_override=5" # If your BIOS artificially underestimates the ACPI to version less than 4.0, and the core is waiting for at least 4.0, if you see errors in dmesg about bios version
      
      # "cgroup_enable=cpuset,cpu,cpuacct,blkio,devices,freezer,net_cls,perf_event,net_prio,hugetlb,pids"
      # "8250.nr_uarts=1" # because in systemd analyze i see many tty and i don need it

      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia.NVreg_TemporaryFilePath=/var/tmp"
      "nvidia.NVreg_UsePageAttributeTable=1"
      "vt.default_utf8=1"
    ];

    kernelModules = [ 
      # "kvm-intel"
      "i915"
      "nvidia_uvm"
      "nvidia"
      "nvidia_modeset"
      "nvidia_drm"
    ];

    blacklistedKernelModules = [ "nouveau" ];

    kernelPackages = pkgs.linuxPackages_latest; # TODO:

    initrd.availableKernelModules = [ 
      "nvme"
      "xhci_pci" 
      "thunderbolt"
      "usb_storage"
      "xhci_hcd" 
      "ehci_hcd"
      "sd_mod" 
      "usbhid"
    ];

    # initrd.systemd.enable = true;
    initrd.verbose = false;
    consoleLogLevel = 0;
  };
}

