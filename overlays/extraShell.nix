{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    # (pkgs.writeShellScriptBin "telegram-desktop" ''
    #   nvidia-offload ${pkgs.telegram-desktop}/bin/telegram-desktop "$@"
    # '') # TODO: its better (i dont know why) this use CPU for video but i want nvidia GPU for it, but feels like its better with this option, i think its use gpu memory for video

    (pkgs.writeShellScriptBin "ssh" ''
      TERM=xterm ${pkgs.openssh}/bin/ssh "$@"
    '')
    # (pkgs.writeShellScriptBin "steam" ''
    #   __NV_PRIME_RENDER_OFFLOAD=1 __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 __VK_LAYER_NV_optimus=NVIDIA_only steam "$@"
    # '') # TODO: good for games, but app interface like with telegram dont want use GPU instead CPU, work with intel cpu, even not intel gpu
    (pkgs.writeShellScriptBin "virt-manager" ''
      mullvad-exclude ${pkgs.virt-manager}/bin/virt-manager "$@"
    '')
    (pkgs.writeShellScriptBin "mpv" ''
      mullvad-exclude ${pkgs.mpv}/bin/mpv "$@"
    '')
    (pkgs.writeShellScriptBin "telegram-desktop" ''
      mullvad-exclude ${pkgs.telegram-desktop}/bin/telegram-desktop "$@"
    '')
    (pkgs.writeShellScriptBin "qbittorrent" ''
      mullvad-exclude ${pkgs.qbittorrent}/bin/qbittorrent "$@"
    '')
    (pkgs.writeShellScriptBin "chromium" ''
      mullvad-exclude ${pkgs.chromium}/bin/chromium "$@"
    '')
    # (pkgs.writeShellScriptBin "element-desktop" ''
    #   mullvad-exclude ${pkgs.chromium}/bin/element-desktop "$@"
    # '')
    # (pkgs.writeShellScriptBin "firefox" ''
    #   /home/dash/.local/bin/sh-rofi/select-profile-firefox--rofi "$@"
    # '')

    # package = pkgs.firefox.overrideAttrs (old: {
    #   desktopItem = old.desktopItem.override {
    #     exec = "env MOZ_USE_XINPUT2=1 firefox --name firefox %U";
    #   };
    # });
  ];
}