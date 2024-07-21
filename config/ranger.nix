{ pkgs, ... }:

{
  enable = true;

  settings = {
    use_preview_script = true;
    preview_images_method = "kitty";
    open_all_images = true;
    EDITOR = "VIM";
  };
}
