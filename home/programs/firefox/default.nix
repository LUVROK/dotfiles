{ pkgs, ... }:

let
    baseDir = ".mozilla/firefox/oepss4ch.default";
in 
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.main = {
      isDefault = true;

      # extensions = with pkgs.firefox-addons; [
      #   simple-translate
      # ];

      settings = {
        "privacy.donottrackheader.enabled" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.pbmode" = true;
        "privacy.query_stripping.enabled" = true;
        "privacy.query_stripping.enabled.pbmode" = true;
        "dom.security.https_first" = true;
        "dom.security.https_first_pbm" = true;
        "privacy.firstparty.isolate" = true;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "sidebar.revamp" = false;
        "svg.context-properties.content.enabled" = true;
        "layout.css.has-selector.enabled" = true;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.trimURLs" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = false;
        "widget.gtk.ignore-bogus-leave-notify" = 1;
        
        "media.ffmpeg.vaapi.enabled" = true;
        "dom.webgpu.enabled" = true;
        "layers.gpu-process.enabled" = true;
        "layers.mlgpu.enabled" = true;
        "media.gpu-process-decoder" = true;
      };

      search = {
        default = "duckduckgo";
        force = true;
      };
    };
  };

  home.file.firefoxChrome = {
    source = ./chrome;
    target = ".mozilla/firefox/main/chrome";
    recursive = true;
  };
}
