{ config, pkgs, ... }:

{
  services.xserver = {
    displayManager.lightdm = {
      enable = true;

      greeters.slick = {
          enable = true;
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