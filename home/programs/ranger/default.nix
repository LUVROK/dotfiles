{ config, lib, pkgs, ... }:

{
  programs.ranger = {
    enable = true;

    package = pkgs.ranger.overrideAttrs (prev: {
      preConfigure = prev.preConfigure + ''
        sed -i -e '/#\s*application\/pdf/,/&& exit\s6/s/#//' ranger/data/scope.sh
        sed -i -e '/#\s*video/,/exit 1/s/#//' ranger/data/scope.sh
      '';
    });

    extraPackages = [
      pkgs.ueberzugpp
      pkgs.ffmpegthumbnailer
      pkgs.poppler_utils
      pkgs.jq
    ];

    settings = {
      preview_images_method = "ueberzug";
      use_preview_script  = true;
      preview_images  = true;
      preview_files  = true;
      open_all_images  = true;
      draw_borders  = false;
      hidden_filter  = ''^lost\+found$|\.parts$'';
      nested_ranger_warning  = true;
      colorscheme  = "solarized";
      autoupdate_cumulative_size = true;
    };

    extraConfig = ''
      map . set show_hidden!
      map dd console delete
      map dt cut mode=toggle
      map pp paste
      map cw console rename%space
      map r    reload_cwd
      # default_linemode devicons2

      map V set visual_mode!
      map a mark
      map A unmark
      map nf console mkdir%space
      map uu shell unzip %f

      map v mark_files toggle=True 
    '';

    plugins = [
      {
        name = "ranger-archives";
        src = builtins.fetchGit {
          url = "https://github.com/maximtrp/ranger-archives";
          ref = "master";
          rev = "b4e136b24fdca7670e0c6105fb496e5df356ef25";
        };
      }
      {
        name = "ranger-devicons2";
        src = builtins.fetchGit {
          url = "https://github.com/cdump/ranger-devicons2";
          ref = "master";
          rev = "94bdcc19218681debb252475fd9d11cfd274d9b1";
        };
      }
    ];
  };
}
