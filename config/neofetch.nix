{ config, pkgs, lib, ... }:

{
  home.file.".config/neofetch/config.conf".text = ''
    image_backend="kitty"
    image_source="${config.home.homeDirectory}/HOME/dotfiles/config/media/neofetch.png"
    image_size="750px"
    image_loop="on"

    # Colors for custom colorblocks
    ascii_colors=(3 3 3 3 1 2 4 5)
    color_blocks="on"
  '';
}