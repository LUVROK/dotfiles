{ pkgs, system, pkgs-pinned, config, inputs, ... }:

let
  baseDir = "${config.home.homeDirectory}/.mozilla/firefox";
  settings = import ./settings.nix { inherit system pkgs; };

  shyfox = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "ShyFox-patch";
    rev = "5b6b814736edc735dd87bc5545b0274284d71252";
    hash = "sha256-EJvIwChfN7iVZr6cySV/kDp/eB35GpLWulSsqQX4qRA=";
  };
in 
{
  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];

  home.file."${config.programs.firefox.configPath}/life/chrome/ShyFox" = {
    recursive = true;
    source = "${shyfox}/chrome/ShyFox";
  };

  home.file."${config.programs.firefox.configPath}/life/chrome/icons" = {
    recursive = true;
    source = "${shyfox}/chrome/icons";
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    profiles = {
      "life" = {
        id = 0;
        isDefault = true;

        extensions.packages =  with pkgs.nur.repos.rycee.firefox-addons; settings.default_extension ++ [ ];
        settings = settings.settings // { };

        search = {
          default = "ddg";
          force = true;
          engines = settings.engines // { };
        };

        extraConfig = pkgs.lib.readFile "${shyfox}/user.js";
        userChrome = pkgs.lib.readFile "${shyfox}/chrome/userChrome.css";
        userContent = pkgs.lib.readFile "${shyfox}/chrome/userContent.css";
      };
      "work" = {
        id = 1;
      };
      "learn" = {
        id = 2;
      };
    };
  };
}
