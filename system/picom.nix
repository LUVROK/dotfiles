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
      # xrender-sync-fence = true;
      use-damage = true;

      # Exclude HDMI-1-0 from picom's effects
      # paint-exclude = [ "monitor = 'HDMI-1'" ];
      fade-exclude = [ 
        # "monitor = 'HDMI-1-0'"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
      ];
      # shadow-exclude = [ "monitor = 'HDMI-1'" ];
      # animation-exclude = [ "monitor = 'HDMI-1'" ];
    };
  };
}