{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-surround
      vim-commentary
      telescope-nvim
    ];
  };
}

