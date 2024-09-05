#!/usr/bin/env sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko --arg device '"/dev/sda"' ./disko.nix && \
sudo nixos-install --root /mnt --flake .#inspiron
