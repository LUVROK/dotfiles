{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "deno"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # --- zsh ---
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    zsh-autocomplete
    zsh-syntax-highlighting
    zsh-autosuggestions
  ];
}