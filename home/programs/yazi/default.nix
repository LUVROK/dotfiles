{ pkgs, config, ... }:
let
  yaziGruvbox = pkgs.fetchFromGitHub {
    owner = "Luvrok";
    repo = "gruvbox-dark.yazi";
    rev = "b8ddd79564687493cf9014b2144dbcf0ebc495c5";
    hash = "sha256-UvClNUDhDr7pdpnzyO4rXa1Ffr37uj1PuiyNW0G7Q+Y=";
  };
in
{
  programs.yazi = {
    enable = true;

    plugins = {
      inherit (pkgs.yaziPlugins) full-border;
    };

    initLua = ''
      require("full-border"):setup()
    '';

    theme = {
      icon = {
        globs = [];
        dirs  = [];
        files = [];
        exts  = [];
        conds = [];
      };
    };

    settings = {
      mgr = {
        ratio = [
          1
          2
          5
        ];
        sort_by = "natural";
        linemod = "none";
        show_hidden = false;
      };
      preview = {
        cache_dir = "${config.xdg.cacheHome}/yazi/preview-cache";
        tab_size = 2;
        max_width = 1920;
        image_filter = "triangle"; # way faster than lanczos3, with no visible loss in image quality (if image_quality have high value).
        image_delay = 30;
        image_quality = 90;
        wrap = "yes";
      };
      tasks = {
        macro_workers = 2;
        image_alloc = 268435456; # 256MB
        image_bound = [0 0];
        suppress_preload = true;
      };
    };
    flavors = {
      gruvbox-dark = yaziGruvbox;
    };
    theme = {
      flavor = {
        use = "gruvbox-dark";
        dark = "gruvbox-dark";
      };
    };
  };
}
