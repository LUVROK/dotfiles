{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    extraConfig = ''
      vnoremap <C-c> "+y
    '';

    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-airline
    ];
  };
}
