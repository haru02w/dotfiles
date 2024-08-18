{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.snow;
in {
  options.modules.programs.snow = {
    enable = mkEnableOption "snow";
    flakePath = mkOption {
      type = with types; str;
      example = "/etc/nixos/flake.nix";
      description = "Path of your NixOS Configuration Flake.";
    };
  };
  config = mkIf cfg.enable {
    programs.nix-data = {
      enable = true;
      flake = cfg.flakePath;
      generations = 5;
    };
  };
}
