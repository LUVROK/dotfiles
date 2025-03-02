{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    # extraLuaConfig = builtins.readFile ./init.lua;
    defaultEditor = true;

    # plugins = with pkgs.vimPlugins; [
    #   nvchad
    #   nvchad-ui
    #   obsidian-nvim
    # ];
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };
}