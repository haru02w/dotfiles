{
  self,
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
    default = config.modules.settings.enable;
    type = types.bool;
  };

  config = mkIf cfg.enable {
    nixpkgs = {
      overlays = self.outputs.overlays;
      config.allowUnfree = mkDefault true;
      config.allowUnfreePredicate = mkDefault (_: true);
    };

    nix = {
      settings = {
        trusted-users = mkDefault ["root" "@wheel"];
        auto-optimise-store = mkDefault true;
        experimental-features = mkDefault ["nix-command" "flakes" "repl-flake"];
        system-features = mkDefault ["kvm" "big-parallel" "nixos-test"];
      };

      gc = {
        automatic = mkDefault true;
        frequency = mkDefault "daily";
        options = mkDefault "--delete-older-than 3d";
      };

      # Add each flake input as a registry
      # To make nix3 commands consistent with the flake
      registry = mkDefault (lib.mapAttrs (_: value: {flake = value;}) inputs);
    };
  };
}
