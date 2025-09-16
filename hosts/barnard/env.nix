{ config, pkgs, lib, ... }:

{
  environment.sessionVariables = {
    XFT_DPI = "112";
    XCURSOR_THEME = "Capitaine Cursors (Gruvbox)";
    GTK_THEME = "gruvbox-dark";
  };

  # NOTE: "DisplayPort-0" and "HDMI-A-0" are the discrete GPU outputs I used before.
  # Issue: kernel panic "BUG at mm/vmalloc.c:3167" reproduced 4–5 times (2025-09-15 → 2025-09-17).
  # Context: AMD + amdgpu with dual-monitor setup; may be related (see forum thread).
  # Mitigation: temporarily using motherboard display outputs to observe; consider pinning an older kernel (has other regressions). No good solution found yet.
  # Ref: https://bbs.archlinux.org/viewtopic.php?id=301280

  environment.etc."X11/xorg.conf.d/60-monitor.conf".text = ''
    Section "Monitor"
      Identifier "HDMI-A-2"
      Modeline "2560x1440R"  497.25  2560 2608 2640 2720  1440 1443 1448 1525 +hsync -vsync
      Option "PreferredMode" "2560x1440R"
      Option "Position" "0 0"
      Option "Primary" "true"
    EndSection
    Section "Monitor"
      Identifier "DisplayPort-2"
      Modeline "2560x1440R"  497.25  2560 2608 2640 2720  1440 1443 1448 1525 +hsync -vsync
      Option "PreferredMode" "2560x1440R"
      Option "Position" "-2560 0"
    EndSection
  '';
  
  isHidpi = false;
}
