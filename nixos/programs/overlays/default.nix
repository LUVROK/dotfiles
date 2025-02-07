{ lib, config, ... }:

{
  imports = [
    # ./steam-nvidia.nix
    ./veracryt.nix
    ./nvidia-offload.nix
  ];
}