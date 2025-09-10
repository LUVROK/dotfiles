{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "ssh" ''
      TERM=xterm ${pkgs.openssh}/bin/ssh "$@"
    '') # TODO: alias

    (pkgs.writeShellScriptBin "mpv" ''
      mullvad-exclude ${pkgs.mpv}/bin/mpv "$@"
    '')

    (pkgs.writeShellScriptBin "telegram-desktop" ''
      mullvad-exclude ${pkgs.telegram-desktop}/bin/telegram-desktop "$@"
    '')

    (pkgs.writeShellScriptBin "qbittorrent" ''
      mullvad-exclude ${pkgs.qbittorrent}/bin/qbittorrent "$@"
    '')

    (pkgs.writeShellScriptBin "steam" ''
      mullvad-exclude ${pkgs.steam}/bin/steam "$@"
    '')

    (pkgs.writeShellScriptBin "prismlauncher" ''
      mullvad-exclude ${pkgs.prismlauncher}/bin/prismlauncher "$@"
    '')
  ];
}