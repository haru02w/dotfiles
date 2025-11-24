{
  inputs,
  lib,
  ...
}: 
let
flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  nix = {
    optimise.automatic = true;

    settings = {
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      system-features = ["kvm" "big-parallel" "nixos-test"];
      flake-registry = ""; # disable global flake registry
    };

    gc = {
      automatic = true;
      randomizedDelaySec = "24h";
      options = "--delete-older-than 3d";
    };

    # Add each flake input on the registry, so I can use `self#config`
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };

  # TODO: add common FHSEnv
  programs.nix-ld.enable = true;
  services.envfs.enable = true;
}
