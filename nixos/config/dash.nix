{ config, ... }:

{
  config.videoDrivers = [
    "nvidia"
    "modesetting"
  ];
  config.dpi = 192;
}
