{ config, pkgs, lib, ... }:

{
  imports = [
    <nixos-hardware/common/gpu/intel/tiger-lake>
    # <nixos-hardware/common/hardware/nouveau.nix>
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [ "nouveau.modeset=1" ];
    kernelModules = [ "kvm-intel" "nouveau" ];
    initrd.kernelModules = [ "nouveau" ];

    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  };

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    
    videoDrivers = [
      # "modesetting"
      "nouveau"
    ];

    dpi = 192;

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

  programs.sway.enable = true;

  environment.systemPackages = with pkgs; [
    dmenu
    st  # простой терминал от suckless
    slock  # простой экранный блокировщик

    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
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
  
  environment.variables = {};

  programs.git = { enable = true; };
  time.hardwareClockInLocalTime = true;
}
