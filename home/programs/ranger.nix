{ pkgs, ... }:

{
  package = pkgs.ranger.overrideAttrs (prev: {
    preConfigure = prev.preConfigure + ''
      sed -i -e '/#\s*application\/pdf/,/&& exit\s6/s/#//' ranger/data/scope.sh
      sed -i -e '/#\s*video/,/exit 1/s/#//' ranger/data/scope.sh
    '';
  });

  enable = true;
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
  '';
}
