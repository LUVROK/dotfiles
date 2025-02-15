{ lib, config, ... }:

let
  user = "dash";  # Замените на ваш юзер
  homeDir = "/home/${user}";
in
{
  imports = [
    ./systemd-network.nix
    ./pipewire.nix
    ./syncthing.nix
    ./display-managers
  ];

  systemd.services.sync-local-files = {
    wantedBy = [ "multi-user.target" ];
    after = [ "default.target" ];

    # Even though echoing the hash is functionally useless at
    # runtime, its inclusion in the service script means that Nix
    # will automatically restart the server whenever the configHash
    # argument is changed.

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "
        mkdir -p ${homeDir}/.local/bin/sh-dwmblocks
        mkdir -p ${homeDir}/.local/bin/sh-rofi
        mkdir -p ${homeDir}/.local/bin/sh-others
        mkdir -p ${homeDir}/.local/bin/sh-nixos
        mkdir -p ${homeDir}/.local/media

        # Даем все права текущему пользователю
        chmod -R u+rwX ${homeDir}/.local/bin/sh-dwmblocks
        chown -R $(whoami):$(whoami) ${homeDir}/.local/bin/sh-dwmblocks

        # Копируем файлы в .local/bin
        # rsync -a ${../../home/sh/sh-dwmblocks}/ ${homeDir}/.local/bin/sh-dwmblocks/
        rsync -a ${../../home/sh/sh-rofi}/ ${homeDir}/.local/bin/sh-rofi/
        rsync -a ${../../home/sh/sh-others}/ ${homeDir}/.local/bin/sh-others/
        rsync -a ${../../home/sh/sh-nixos}/ ${homeDir}/.local/bin/sh-nixos/
        cp ${../../home/programs/dwmblocks-async/result/bin/dwmblocks} ${homeDir}/.local/bin/sh-dwmblocks/dwm-dwmblocks

        # Копируем файлы в .local/media
        rsync -a ${../../home/media}/ ${homeDir}/.local/media/
      ";
    };
  };

  # systemd.user.services.sync-local-files = {    
  #   Unit = {
  #     After = [ "default.target" ];
  #   };

  #   Service = {
  #     Type = "oneshot";
  #      ExecStart = pkgs.writeShellScript "sync-local-files" ''
  #       mkdir -p ${homeDir}/.local/bin/sh-dwmblocks
  #       mkdir -p ${homeDir}/.local/bin/sh-rofi
  #       mkdir -p ${homeDir}/.local/bin/sh-others
  #       mkdir -p ${homeDir}/.local/bin/sh-nixos
  #       mkdir -p ${homeDir}/.local/media

  #       # Даем все права текущему пользователю
  #       chmod -R u+rwX ${homeDir}/.local/bin/sh-dwmblocks
  #       chown -R $(whoami):$(whoami) ${homeDir}/.local/bin/sh-dwmblocks

  #       # Копируем файлы в .local/bin
  #       rsync -a ${./sh/sh-dwmblocks}/ ${homeDir}/.local/bin/sh-dwmblocks/
  #       rsync -a ${./sh/sh-rofi}/ ${homeDir}/.local/bin/sh-rofi/
  #       rsync -a ${./sh/sh-others}/ ${homeDir}/.local/bin/sh-others/
  #       rsync -a ${./sh/sh-nixos}/ ${homeDir}/.local/bin/sh-nixos/
  #       cp ${./programs/dwmblocks-async/result/bin/dwmblocks} ${homeDir}/.local/bin/sh-dwmblocks/dwm-dwmblocks

  #       # Копируем файлы в .local/media
  #       rsync -a ${./media}/ ${homeDir}/.local/media/
  #     '';
  #     Environment = [
  #       "PATH=/home/dash/.local/bin/sh-others:${lib.makeBinPath [
  #         pkgs.bash 
  #         pkgs.coreutils 
  #         pkgs.rsync 
  #       ]}"
  #     ];
  #   };

  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  # };
}