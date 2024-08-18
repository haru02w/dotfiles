{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.fhsHelpers;
in {
  options.modules.fhsHelpers.enable = mkEnableOption "FHS compliant";
  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
    services.envfs.enable = true;
    environment.systemPackages = with pkgs; [
      nix-alien
    ];
  };
}
