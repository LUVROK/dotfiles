#!/bin/sh
pushd ~/HOME/dotfiles
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix &&
notify-send "nix-channel update completed successfully" && 
paplay $HOME/HOME/wizzard/media/soundeffect/minecraft-sheep2.mp3
popd
