{ pkgs, system, pkgs-pinned, config, inputs, ... }:

let
  baseDir = "${config.home.homeDirectory}/.mozilla/firefox";
  settings = import ./settings.nix { inherit system pkgs; };

  shyfox = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "ShyFox-patch";
    rev = "48cbbb8c0605343c68bbdc20d6ed4b9c6ef90260";
    hash = "sha256-Ety1Ura6qBvHFGaTKcTzg6qGa/7dP+1RIRXdjIaO4o0=";
  };

  extension = shortId: extension_id: {
    name = extension_id;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
      allowed_in_private_browsing = true;
    };
  };
in 
{
  # nixpkgs.overlays = [
  #   inputs.nur.overlays.default
  # ];

  home.file."${config.programs.firefox.configPath}/life/chrome" = {
    recursive = true;
    source = "${shyfox}/chrome";
  };

  home.file."${config.programs.firefox.configPath}/test2/chrome" = {
    recursive = true;
    source = "${shyfox}/chrome";
  };

  home.file."${config.programs.firefox.configPath}/sapphire/chrome" = {
    recursive = true;
    source = "${shyfox}/chrome";
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    nativeMessagingHosts = [ pkgs.vdhcoapp ];

    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxStudies = true;

      ExtensionSettings = {

      } //
      builtins.listToAttrs [
        (extension "markdown-here" "markdown-here-webext@adam.pritchard")
        (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
        (extension "sponsorblock" "sponsorBlocker@ajay.app")
        (extension "ublock-origin" "uBlock0@raymondhill.net")
        (extension "userchrome-toggle-extended" "userchrome-toggle-extended@n2ezr.ru")
        (extension "decentraleyes" "jid1-BoFifL9Vbdl2zQ@jetpack")
        (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
        (extension "traduzir-paginas-web" "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}")
        (extension "remove-youtube-shorts" "{2766e9f7-7bf2-4c72-81b9-d119eb54c753}")
        (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
        (extension "simple-translate" "simple-translate@sienori")
        (extension "port-authority" "{6c00218c-707a-4977-84cf-36df1cef310f}")
        (extension "canvasblocker" "CanvasBlocker@kkapsner.de")
        (extension "dont-track-me-google1" "dont-track-me-google@robwu.nl")
        (extension "gruvboxtheme" "{fd4fdeb0-5a65-4978-81c5-3488d4d56426}")
        (extension "chameleon-ext" "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}")
        (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
        (extension "foxyproxy-standard" "foxyproxy@eric.h.jung")
        (extension "video-downloadhelper" "{b9db16a4-6edc-47ec-a1f4-b86292ed211d}")
        # (extension "" "")
      ];
    };

    profiles = {
      "life" = {
        id = 0;
        isDefault = true;

        # extensions.packages =  with pkgs.nur.repos.rycee.firefox-addons; settings.default_extension ++ [ ];
        settings = settings.settings // { };

        search = {
          default = "ddg";
          force = true;
          engines = settings.engines // { };
        };

        extraConfig = pkgs.lib.readFile "${shyfox}/user.js";
        # userChrome = pkgs.lib.readFile "${shyfox}/chrome/userChrome.css";
        # userContent = pkgs.lib.readFile "${shyfox}/chrome/userContent.css";
      };
      "work" = {
        id = 1;
      };
      "learn" = {
        id = 2;

        settings = settings.settings // { };

        search = {
          default = "ddg";
          force = true;
          engines = settings.engines // { };
        };
      };
      "test2" = {
        id = 3;
        
        # extensions.packages =  with pkgs.nur.repos.rycee.firefox-addons; settings.default_extension ++ [ ];
        settings = settings.settings // { };

        search = {
          default = "ddg";
          force = true;
          engines = settings.engines // { };
        };

        extraConfig = pkgs.lib.readFile "${shyfox}/user.js";
        # userChrome = pkgs.lib.readFile "${shyfox}/chrome/userChrome.css";
        # userContent = pkgs.lib.readFile "${shyfox}/chrome/userContent.css";
      };
      "sapphire" = {
        id = 4;
        
        # extensions.packages =  with pkgs.nur.repos.rycee.firefox-addons; settings.default_extension ++ [ ];
        settings = settings.settings // { };

        search = {
          default = "ddg";
          force = true;
          engines = settings.engines // { };
        };

        extraConfig = pkgs.lib.readFile "${shyfox}/user.js";
        # userChrome = pkgs.lib.readFile "${shyfox}/chrome/userChrome.css";
        # userContent = pkgs.lib.readFile "${shyfox}/chrome/userContent.css";
      };
    };
  };
}
