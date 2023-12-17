#! /usr/bin/env sh
sudo nixos-rebuild switch --flake .#vm
home-manager switch --flake .#haru02w
