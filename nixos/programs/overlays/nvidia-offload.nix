{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "telegram-desktop" ''
      nvidia-offload ${pkgs.telegram-desktop}/bin/telegram-desktop "$@"
    '') # TODO: its better (i dont know why) this use CPU for video but i want nvidia GPU for it, but feels like its better with this option, i think its use gpu memory for video
    (pkgs.writeShellScriptBin "steam" ''
     env GDK_SCALE=1.5 nvidia-offload ${pkgs.steam}/bin/steam "$@"
    '') # TODO: good work for games, but app interface like with telegram dont want use GPU instead CPU, work with intel integrate gpu but not with nvidia
  ];
}