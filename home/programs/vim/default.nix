{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = false;

    plugins = with pkgs.vimPlugins; [ 

    ];
  };
}
