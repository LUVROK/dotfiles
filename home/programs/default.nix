{ lib, config, pkgs, nixosConfig, ... }:

{
  imports = [
    ./neofetch.nix
    ./firefox
    ./ranger
    ./nnn
    ./neovim
    ./vim
    ./git.nix
    ./gpg
    ./rofi/rofi.nix
  ];

  home.file.".config/mpv".source = ./mpv;

  programs = {
    kitty = (import ./kitty/kitty.nix { inherit pkgs nixosConfig; });

    obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };
      # enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        #obs-vaapi
        #obs-tuna
        #obs-source-clone
        obs-pipewire-audio-capture
        #input-overlay
        obs-vkcapture
        obs-backgroundremoval
        obs-vaapi # optional AMD hardware acceleration
        obs-gstreamer
      ];
    };
  };
}