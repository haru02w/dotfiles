{ inputs, lib, outputs, ... }: {
  imports = [ inputs.nix-gc-env.nixosModules.default ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
    config.allowUnfreePredicate = _: true;
  };

  nix = {
    optimise.automatic = true;

    settings = {
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      system-features = [ "kvm" "big-parallel" "nixos-test" ];
      flake-registry = ""; # Disable global flake registry
    };

    gc = {
      automatic = true;
      dates = "*-*-* 10:00:00";
      # Keep the last 5 generations
      delete_generations = "+5"; # Option added by nix-gc-env
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };
}
