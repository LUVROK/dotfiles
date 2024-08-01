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
}
