with import <nixpkgs> {};

mkShell {
  buildInputs = [ stdenv xorg.libX11 xorg.libxcb xorg.xcbutil pkg-config ];
}