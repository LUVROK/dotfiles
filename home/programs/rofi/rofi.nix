{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    pass = {
      enable = true;
      package = pkgs.rofi-pass;
      stores = [ "$HOME/.password-store" ];
      extraConfig =  
        let
          remove-binding =
            binding: str:
            let
              bindings = lib.strings.splitString "," str;
            in
            let
              newBindings = lib.lists.remove binding bindings;
            in
            lib.strings.concatStringsSep "," newBindings;
        in
        with config.programs.rofi.extraConfig;
        ''
        _rofi () {
          ${config.programs.rofi.package}/bin/rofi \
            -i \
            -kb-accept-custom "" \
            -kb-row-down "${remove-binding "Control+n" kb-row-down}" \
            -kb-row-up "${remove-binding "Control+p" kb-row-up}" \
            -kb-mode-complete "" \
            -kb-remove-char-back "BackSpace,Shift+BackSpace" \
            -kb-move-front "" \
            -kb-remove-to-sol "" \
            -no-auto-select \
            -theme "$HOME"/.config/rofi/rofi-pass.rasi\
            "$@"
        }

        _pwgen () {
          ${pkgs.pwgen}/bin/pwgen -y "$@"
        }

        _clip_in_primary() {
          xclip
        }

        _clip_in_clipboard() {
          xclip -selection clipboard
        }

        _clip_out_primary() {
          xclip -o
        }

        _clip_out_clipboard() {
          xclip --selection clipboard -o
        }

        default_autotype="user :tab pass"
        delay=2
        wait=0.2
        type_delay=12
        default_do='menu' # menu, copyPass, typeUser, typePass, copyUser, copyUrl, viewEntry, typeMenu, actionMenu, copyMenu, openUrl
        auto_enter='true'
        notify='false'
        clip=both
        clip_clear=45
        default_user="barnard"
        default_user2=john_doe
        password_length=12
        fix_layout=false

        # Custom Keybindings
        autotype="Control+Return"
        type_user="Control+u"
        type_pass="Control+p"
        open_url="Control+l"
        copy_name="Alt+u"
        copy_url="Alt+l"
        copy_pass="Alt+p"
        show="Control+o"
        # copy_menu="Control+c"
        action_menu="Control+a"
        type_menu="Control+t"
        help="Control+h"
        switch="Control+x"
        insert_pass="Control+n"
      '';
    };
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = ./config/based.rasi;
    extraConfig = {
      show-icons = false;
      # Remove some keys from the default bindings
      kb-accept-entry = "Control+m,Return,KP_Enter"; # Removed Control+j
      kb-remove-to-eol = ""; # Removed Control+k
      # Set our custom bindings
      kb-row-down = "Down,Control+n,Control+j";
      kb-row-up = "Up,Control+p,Control+k";
    };
  };

  xdg.configFile = {
    based-rasi = {
      source = ./config/based.rasi;
      target = "rofi/based.rasi";
    };
    rofi-pass-rasi = {
      source = ./config/rofi-pass.rasi;
      target = "rofi/rofi-pass.rasi";
    };
    pinentry-theme-rasi = {
      source = ./config/pinentry-theme.rasi;
      target = "rofi/pinentry-theme.rasi";
    };
    keyring-rasi = {
      source = ./config/keyring.rasi;
      target = "rofi/keyring.rasi";
    };
    colors-rasi = {
      source = ./config/colors.rasi;
      target = "rofi/colors.rasi";
    };
    firefox-rasi = {
      source = ./config/firefox-profiles-menu.rasi;
      target = "rofi/firefox-profiles-menu.rasi";
    };
    font-rasi = {
      source = ./config/font.rasi;
      target = "rofi/font.rasi";
    };
    powermenu-rasi = {
      source = ./config/power-menu.rasi;
      target = "rofi/power-menu.rasi";
    };
    crypto-rasi = {
      source = ./config/crypto-menu.rasi;
      target = "rofi/crypto-menu.rasi";
    };
    greenclip-rasi = {
      source = ./greenclip/greenclip.rasi;
      target = "rofi/greenclip.rasi";
    };
    greenclip-toml = {
      source = ./greenclip/greenclip.toml;
      target = "greenclip.toml";
    };
  };
}