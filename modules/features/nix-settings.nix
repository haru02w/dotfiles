{
  inputs,
  lib,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  den.aspects.nix-settings = {
    os = {
      nix = {
        optimise.automatic = true;
        settings = {
          trusted-users = ["root" "@wheel"];
          experimental-features = ["nix-command" "flakes"];
          system-features = ["kvm" "big-parallel" "nixos-test"];
          flake-registry = ""; # disable global flake registry
        };
        gc = {
          automatic = true;
          options = "--delete-older-than 7d";
        };
        # Add each flake input on the registry, so I can use `self#config`
        registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        # This lets nix commands still use <nixpkgs>
        nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
      };
    };

    homeManager = {
      nix = {
        settings = {
          trusted-users = ["root" "@wheel"];
          experimental-features = ["nix-command" "flakes"];
          system-features = ["kvm" "big-parallel"];
          flake-registry = ""; # disable global flake registry
        };

        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than 3d";
        };

        registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      };
    };
  };
}
