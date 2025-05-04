{ config, pkgs, lib, ... }:

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

        efiInstallAsRemovable = true; # probably dangerous if you using windows like secons boot espessialy
        device = "nodev";
        # configurationLimit = 10;
        useOSProber = true;
        timeoutStyle = "menu";

        # extraEntriesAfterNixOS = true;
        # extraEntries = ''
        #   menuentry "Reboot" {
        #     reboot
        #   }
        #   menuentry "Poweroff" {
        #     halt
        #   }
        # '';

        minegrub-theme = {
          enable = true;
          splash = "100% Flakes!";
          background = "background_options/1.18 - [Caves And Cliffs 2].png";
          boot-options-count = 2;
        };
      };

      timeout = 3;
    };

    kernelParams = [
      "quiet"
      "splash"
      "nvidia-drm.modeset=1" 
      "i915.force_probe=9a49"
      # "usbcore.autosuspend=-1"
      "acpi_enforce_resources=lax"
      "acpi_rev_override=5" # If your BIOS artificially underestimates the ACPI to version less than 4.0, and the core is waiting for at least 4.0, if you see errors in dmesg about bios version
      # "cgroup_enable=cpuset,cpu,cpuacct,blkio,devices,freezer,net_cls,perf_event,net_prio,hugetlb,pids"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      # "8250.nr_uarts=1" # because in systemd analyze i see many tty and i don need it
    ];

    kernelModules = [ 
      # "kvm-intel"
      "nvidia_uvm"
      "nvidia"
      "nvidia_modeset"
      "nvidia_drm"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "xhci_hcd" "ehci_hcd" "sd_mod" "usbhid" ];

    initrd.systemd.enable = true;
    initrd.verbose = false;
    consoleLogLevel = 0;
    # tmp.cleanOnBoot = true; # not good for dwmblocks

    plymouth = {
      enable = true;
      # theme = "spinfinity";
      theme = "dna";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "dna" ];
        })
      ];
    };
  };
}

