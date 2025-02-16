{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    # (pkgs.writeShellScriptBin "telegram-desktop" ''
    #   nvidia-offload ${pkgs.telegram-desktop}/bin/telegram-desktop "$@"
    # '') # TODO: its better (i dont know why) this use CPU for video but i want nvidia GPU for it, but feels like its better with this option, i think its use gpu memory for video

    (pkgs.writeShellScriptBin "ssh" ''
      TERM=xterm ${pkgs.openssh}/bin/ssh "$@"
    '')
    (pkgs.writeShellScriptBin "steam" ''
      env GDK_SCALE=2 mullvad-exclude nvidia-offload ${pkgs.steam}/bin/steam "$@"
    '') # TODO: good for games, but app interface like with telegram dont want use GPU instead CPU, work with intel cpu, even not intel gpu
    (pkgs.writeShellScriptBin "virt-manager" ''
      mullvad-exclude ${pkgs.virt-manager}/bin/virt-manager "$@"
    '')
    (pkgs.writeShellScriptBin "firefox" ''
      select-profile-firefox--rofi "$@"
    '')

    # package = pkgs.firefox.overrideAttrs (old: {
    #   desktopItem = old.desktopItem.override {
    #     exec = "env MOZ_USE_XINPUT2=1 firefox --name firefox %U";
    #   };
    # });
  ];
}