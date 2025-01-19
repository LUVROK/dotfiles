{ config, pkgs, ... }:

{
  services.xserver = {
    displayManager.lightdm = {
      enable = false;

      greeters.slick = {
          enable = false;
          theme = {
            name = "vimix-dark-ruby";
            package = pkgs.vimix-gtk-themes.override {
              themeVariants = ["ruby"];
              colorVariants = ["dark"];
              tweaks = ["flat" "grey"];
            };
          };
        iconTheme = {
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
        };
        extraConfig = ''
          show-a11y=false
          clock-format=%H:%M:%S
        '';
      };
    };
  };
}