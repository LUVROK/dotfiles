{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    settings = {
      fading = true;
      fade-in-step = 0.03;
      fade-out-step = 0.03;

      animations = true;
      animation-stiffness = 120;
      animation-duration = 200;

      unredir-if-possible = false;
      unredir-if-possible-delay = 5000;
      unredir-if-possible-exclude = [ "class_g = 'mpv'" ];

      experimental-backends = false;

      blur-method = "none";
      glx-no-stencil = true;
      glx-no-rebind-pixmap = true;
      use-damage = true;

      fade-exclude = [ 
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
      ];
    };
  };
}