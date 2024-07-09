#!/bin/sh
pushd ~/HOME/dotfiles
home-manager switch -f ./home.nix
popd
