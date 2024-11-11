{ pkgs, lib, ... }: 

{
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.breeze-qt5;
    name = "breeze_cursors";
    size = 32;
  };

  home.file."/home/dash/.icons/default".source =
    "${lib.getBin pkgs.breeze-qt5}/share/icons/breeze_cursors";

  home.file."/home/dash/.icons/Breeze".source =
    "${lib.getBin pkgs.breeze-qt5}/share/icons/breeze_cursors";
}