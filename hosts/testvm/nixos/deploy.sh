#!/usr/bin/env sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko --arg device '"/dev/vda"' ./disko.nix && \
sudo nixos-generate-config --no-filesystems --root /mnt --show-hardware-config > ./hardware-configuration.nix
yes | sudo nixos-install --root /mnt --flake .#testvm
