{ ... }:

{
  enable = true;
  backend = "egl";
  vSync = true;

  settings = {
    dbus = true;

    fading = true;
    fade-in-step = 0.08;
    fade-out-step = 0.08;

    animations = true;
    animation-stiffness = 120;
    animation-duration = 240;

    experimental-backends = true;

    fade-exclude = [
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
    ];

    no-fading-openclose = false;
    no-fading-destroyed-argb = true;

    unredir-if-possible-exclude = [ "class_g = 'mpv'" "class_g = 'Firefox'" ];

    log-level = "warn";
    log-file = "~/.cache/picom-log.log";
    show-all-xerrors = true;
  };
}
