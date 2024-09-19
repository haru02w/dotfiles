{
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.settings.nix;
in {
  options.modules.settings.nix.enable = mkOption {
    description = "Enable nix config";
    default = true;
    type = types.bool;
  };

  config = mkIf cfg.enable {
    nix = {
      settings = {
        trusted-users = ["root" "@wheel"];
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes" "repl-flake"];
        system-features = ["kvm" "big-parallel" "nixos-test"];
      };

      gc = {
        automatic = true;
        frequency = "daily";
        options = "--delete-older-than 3d";
      };

      # Add each flake input as a registry
      # To make nix3 commands consistent with the flake
      registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    };
  };
}
