{ pkgs, ... }:

{
  hardware.openrazer = {
    enable = true;
    users = [ "barnard" ];
    batteryNotifier = {
      enable = true;
      percentage = 10;
    };
  };

  environment.systemPackages = with pkgs; [
    razer-cli
    openrazer-daemon
    polychromatic
  ];
}