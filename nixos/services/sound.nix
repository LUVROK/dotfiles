{ lib, config, pkgs, ... }:

{  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.pulseaudio.enable = false;

  security.rtkit.enable = true;
  environment.systemPackages = with pkgs; [
    pulseaudio
    alsa-utils
    pavucontrol
  ];
}