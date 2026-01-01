{ config, lib, pkgs, inputs, ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''
        source "${inputs.zinit}/zinit.zsh"
      ''
      + builtins.readFile ./zshrc;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
