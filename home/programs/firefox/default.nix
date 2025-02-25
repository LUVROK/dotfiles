{ pkgs, config, inputs, ... }:

let
    baseDir = "${config.home.homeDirectory}/.mozilla/firefox";
in 
{  
  home.file.".mozilla/firefox/mankind.main/chrome/ShyFox".source = ./ShyFox/chrome/ShyFox;
  home.file.".mozilla/firefox/mankind.main/chrome/userChrome.css".source = ./ShyFox/chrome/userChrome.css;
  home.file.".mozilla/firefox/mankind.main/chrome/userContent.css".source = ./ShyFox/chrome/userContent.css;
  home.file.".mozilla/firefox/mankind.main/chrome/1130469.png".source = ./ShyFox/chrome/1130469.png;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    profiles = {
      "textfox2" = {
        id = 3;
        isDefault = false;
        path = "4q9o09eg.textfox2";
        # extensions = ff-extensions;
      };
      "lowdpi" = {
        id = 2;
        isDefault = false;
        path = "czgen8cr.lowdpi";
        # extensions = ff-extensions;
      };
      "textfox" = {
        id = 1;
        isDefault = false;
        path = "g4fs32ww.textfox";
        # extensions = ff-extensions;
      };
      "default" = {
        id = 0;
        isDefault = true;
        path = "oepss4ch.default";
        # settings = default_settings;
        # extensions = ff-extensions;

        # extensions = [];
      };

      "main" = {
        id = 4;
        isDefault = false;
        path = "mankind.main";

        # search.default = "DuckDuckGo";

        # userChrome = import ./ShyFox/chrome/userChrome.nix;
        # userContent = import ./ShyFox/chrome/userContent.nix;

        # settings = default_settings // {
        #   "layout.css.devPixelsPerPx" = 1;
        # };

        # extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        #   canvasblocker
        #   decentraleyes
        #   sidebery
        #   privacy-badger
        #   stylus
        #   multi-account-containers
        #   ublock-origin
        # ];
      };
    };

    # profiles.main = {
    #   isDefault = true;

    #   # extensions = with pkgs.firefox-addons; [
    #   #   simple-translate
    #   # ];

    #   settings = {
    #     "privacy.donottrackheader.enabled" = true;
    #     "privacy.resistFingerprinting" = true;
    #     "privacy.fingerprintingProtection" = true;
    #     "privacy.fingerprintingProtection.pbmode" = true;
    #     "privacy.query_stripping.enabled" = true;
    #     "privacy.query_stripping.enabled.pbmode" = true;
    #     "dom.security.https_first" = true;
    #     "dom.security.https_first_pbm" = true;
    #     "privacy.firstparty.isolate" = true;

    #     "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    #     "sidebar.revamp" = false;
    #     "svg.context-properties.content.enabled" = true;
    #     "layout.css.has-selector.enabled" = true;
    #     "browser.urlbar.suggest.calculator" = true;
    #     "browser.urlbar.unitConversion.enabled" = true;
    #     "browser.urlbar.trimHttps" = true;
    #     "browser.urlbar.trimURLs" = true;
    #     "widget.gtk.rounded-bottom-corners.enabled" = false;
    #     "widget.gtk.ignore-bogus-leave-notify" = 1;
        
    #     "media.ffmpeg.vaapi.enabled" = true;
    #     "dom.webgpu.enabled" = true;
    #     "layers.gpu-process.enabled" = true;
    #     "layers.mlgpu.enabled" = true;
    #     "media.gpu-process-decoder" = true;
    #   };

    #   search = {
    #     default = "duckduckgo";
    #     force = true;
    #   };
    # };
  };

  # home.file.firefoxChrome = {
  #   source = ./ShyFox/chrome;
  #   target = ".mozilla/firefox/main/chrome";
  #   recursive = true;
  # };
}
