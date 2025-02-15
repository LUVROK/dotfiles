{ config, pkgs, lib, ... }:

let
  user = "dash";  # Замените на ваш юзер
  homeDir = "/home/${user}";
in
{
  programs.home-manager.enable = true;

  imports = [
    ./packages.nix
    ./services
    ./programs
    ./modules
  ];

  home.username = "dash";
  home.homeDirectory = "/home/dash";
  home.stateVersion = "24.05";

  # pkgs.stdenv.mkDerivation {
  #   name = "windows";
  #   nativeBuildInputs = [ pkgs.copyDesktopItems ];
  #   installPhase = ''
  #     mkdir -p $out/bin $out/share
  #     cp ${bin}/bin/windows $out/bin/
  #     copyDesktopItems
  #   '';
  #   phases = [ "installPhase" ];
    
  #   desktopItems = [
  #     (pkgs.makeDesktopItem {
  #       name = "windows";
  #       desktopName = "Windows";
  #       icon = "windows95";
  #       exec = "windows";
  #       type = "Application";
  #       startupWMClass = "windows";
  #     })
  #   ];
  # };

  # home.file.".local/bin".source = pkgs.runCommand "merge-folders" {} ''
  #   mkdir -p $out/sh-dwmblocks
  #   mkdir -p $out/sh-rofi
  #   mkdir -p $out/sh-others
  #   mkdir -p $out/sh-nixos
  #   cp -r ${./programs/dwmblocks-async/result/bin}/* $out/sh-dwmblocks
  #   cp -r ${./sh/sh-dwmblocks}/* $out/sh-dwmblocks
  #   cp -r ${./sh/sh-rofi}/* $out/sh-rofi
  #   cp -r ${./sh/sh-others}/* $out/sh-others
  #   cp -r ${./sh/sh-nixos}/* $out/sh-nixos
  #   mv $out/sh-dwmblocks/dwmblocks $out/sh-dwmblocks/dwm-dwmblocks
  # '';

  # home.file.".local/media".source = pkgs.runCommand "merge-folders" {} ''
  #   mkdir -p $out/media
  #   cp -r ${./media}/* $out
  # '';

  systemd.user.services.sync-local-files = {    
    Unit = {
      After = [ "default.target" ];
    };

    Service = {
      Type = "oneshot";
       ExecStart = pkgs.writeShellScript "sync-local-files" ''
        # mkdir -p ${homeDir}/.local/bin/sh-dwmblocks
        # mkdir -p ${homeDir}/.local/bin/sh-rofi
        # mkdir -p ${homeDir}/.local/bin/sh-others
        # mkdir -p ${homeDir}/.local/bin/sh-nixos
        # mkdir -p ${homeDir}/.local/media

        # # Даем все права текущему пользователю
        # chmod -R u+rwX ${homeDir}/.local/bin/sh-dwmblocks
        # chown -R $(whoami):$(whoami) ${homeDir}/.local/bin/sh-dwmblocks

        # # Копируем файлы в .local/bin
        # rsync -a ${./sh/sh-dwmblocks}/ ${homeDir}/.local/bin/sh-dwmblocks/
        # rsync -a ${./sh/sh-rofi}/ ${homeDir}/.local/bin/sh-rofi/
        # rsync -a ${./sh/sh-others}/ ${homeDir}/.local/bin/sh-others/
        # rsync -a ${./sh/sh-nixos}/ ${homeDir}/.local/bin/sh-nixos/
        # # cp ${./programs/dwmblocks-async/result/bin/dwmblocks} ${homeDir}/.local/bin/sh-dwmblocks/dwm-dwmblocks

        # # Копируем файлы в .local/media
        # rsync -a ${./media}/ ${homeDir}/.local/media/
      '';
      Environment = [
        "PATH=/home/dash/.local/bin/sh-others:${lib.makeBinPath [
          pkgs.bash 
          pkgs.coreutils 
          pkgs.rsync 
        ]}"
      ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
  
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
}
