{ pkgs, username, ... }:

{
  hardware.openrazer = {
    enable = true;
    users = [ "${username}" ];
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