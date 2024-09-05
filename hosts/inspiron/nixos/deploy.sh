#!/usr/bin/env sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko --arg device '"/dev/sda"' ./disko.nix && \
yes | sudo nixos-install --root /mnt --flake .#inspiron
