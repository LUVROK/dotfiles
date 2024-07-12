{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    extraConfig = ''
      vnoremap <C-c> "+y
    '';
  };
}
