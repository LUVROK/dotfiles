{ config, pkgs, ... }:

{
  services.xserver.windowManager.dwm.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/dash/HOME/dotfiles/wm/dwm ;});
    })
    (final: prev: {
      dmenu = prev.dmenu.overrideAttrs (old: { src = /home/dash/HOME/dotfiles/wm/dmenu ;});
    })
    (final: prev: {
      slstatus = prev.slstatus.overrideAttrs (old: { src = /home/dash/HOME/dotfiles/wm/slstatus ;});
    })
  ];
}
