# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../shared.nix
    ];
  boot.loader = {
    grub.enable = true;
    grub.device = "/dev/vda"; 
  };

  networking.hostName = "vm";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "24.05";
}

