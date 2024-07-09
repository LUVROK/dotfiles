{ config, ... }:

{
  services.libinput = {
    enable = true;
    
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      clickMethod = "clickfinger";
      horizontalScrolling = false;
      disableWhileTyping = true;
    };
  };

  # services.xserver.inputClassSections = [
    # ''
    # Section "InputClass"
      # Identifier "touchpad"
      # MatchIsTouchpad "on"
      # Driver "libinput"
          # Option "ClickMethod" "clickfinger"
      # Option "MiddleEmulation" "off"
    # EndSection
    # ''
  # ];
}
