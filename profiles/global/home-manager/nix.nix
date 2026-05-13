{
  inputs,
  lib,
  pkgs,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nix = {
    package = lib.mkForce pkgs.nix;
    settings = {
      trusted-users = ["root" "@wheel"];
      experimental-features = ["nix-command" "flakes"];
      system-features = ["kvm" "big-parallel"];
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };

    # filter drops non-flake inputs (e.g. tmux-toggle-scratch)
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
  };
}
