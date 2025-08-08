{ config, lib, pkgs, pkgs-pinned, ... }:

{
  services.picom = {
    enable = true;
    backend = "egl"; # glx also good
    vSync = true;

    settings = {
      dbus = true;

      fading = true;
      fade-in-step = 0.08;
      fade-out-step = 0.08;

      animations = true;
      animation-stiffness = 120;
      animation-duration = 240;

      # unredir-if-possible = true;
      # unredir-if-possible-delay = 5000;
      # unredir-if-possible-exclude = [ "class_g = 'mpv'" "class_g = 'Firefox'" ];

      experimental-backends = true;

      fade-exclude = [ 
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
      ];

      no-fading-openclose = false;
      no-fading-destroyed-argb = true;

      unredir-if-possible-exclude = [ "class_g = 'mpv'" "class_g = 'Firefox'" ];

      # resize-damage = 1;
      # glx-no-stencil = true;
      # use-damage = true;
      # glx-no-rebind-pixmap = true;
      # glx-swap-method = 1;

      log-level = "warn";
      log-file = "~/.cache/picom-log.log";
      show-all-xerrors = true;
    };
  };
}