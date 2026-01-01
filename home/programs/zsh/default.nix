{ config, lib, pkgs, inputs, ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''
        source "${inputs.zinit}/zinit.zsh"
      ''
      + builtins.readFile ./zshrc;
    envExtra = ''
      [[ -o interactive && -t 0 ]] || return
      stty -echo -icanon time 0 min 0 2>/dev/null
    '';
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
