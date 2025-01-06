{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  imports = [ 
    ./config/vim/vim.nix
    ./config/cursor.nix
    ./config/rofi/rofi.nix
    ./config/dunst.nix
    ./config/flameshot.nix
    ./config/neofetch.nix
    ./config/redshift.nix
  ];

  home.username = "dash";
  home.homeDirectory = "/home/dash";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    direnv
    kitty
    neofetch
    p7zip
    tree-sitter
    dunst
    rnnoise-plugin
    helvum
    ly

    # pass
    pinentry
    gnupg
    pass

    # utils
    haskellPackages.greenclip
  ];

  # Внутри секции home или config
  home.file.".local/bin".source = ./system/dwm-flexipatch/dwmblocks-async/dwmblocks/scripts;

  # Убедитесь, что ~/.local/bin находится в $PATH
  home.sessionVariables.PATH = "${config.home.homeDirectory}/.local/bin";

  home.file.".gnupg/gpg-agent.conf" = {
    text = ''
      pinentry-program ${pkgs.pinentry}/bin/pinentry
    '';
    onChange = ''
      echo "Reloading gpg-agent"
      echo RELOADAGENT | gpg-connect-agent
    '';
  };

  home.file.".Xmodmap".text = ''
    keycode  37 = Control_L NoSymbol Control_L
    keycode  50 = Shift_L NoSymbol Shift_L
  '';

  home.file.".config/.asoundrc".text = ''
    defaults.pcm.card 1
    defaults.ctl.card 1
  '';

  home.file.".config/pipewire/pipewire.conf.d/99-input-denoising.conf".text = ''
    context.modules = [
      {
        name = libpipewire-module-filter-chain
        args = {
          node.description =  "Noise Canceling source"
          media.name =  "Noise Canceling source"
          filter.graph = {
            nodes = [
              {
                type = ladspa
                name = rnnoise
                plugin = ${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so
                label = noise_suppressor_mono
                control = {
                  "VAD Threshold (%)" 95.0
                  "VAD Grace Period (ms)" 200
                  "Retroactive VAD Grace (ms)" 0
                }
              }
            ]
          }
          capture.props = {
            node.name =  "capture.rnnoise_source"
            node.passive = true
            audio.rate = 48000
          }
          playback.props = {
            node.name =  "rnnoise_source"
            media.class = Audio/Source
            audio.rate = 48000
          }
        }
      }
    ]
  '';

  systemd.user.services.dwmblocks = {
    Unit = {
      Description = "Status feed generator for dwm";
      After = [
        "default.target"
        "pipewire.service"
        "wireplumber.service"
      ];
      Wants = [
        "pipewire.service"
        "wireplumber.service"
      ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };

    Service = {
      ExecStart = "/home/dash/HOME/dotfiles/system/dwm-flexipatch/dwmblocks-async/result/bin/dwmblocks";
      Restart = "always";
      RestartSec = 3;
      # Environment = "PATH=/home/dash/.local/bin"; # Укажите свой $PATH
    };
  };

  programs = {
    ranger = (import ./config/ranger.nix { inherit pkgs; });
    kitty = (import ./config/kitty/kitty.nix { inherit pkgs; });
  };
}
