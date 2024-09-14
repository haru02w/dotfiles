{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.fhsHelpers;
in {
  options.modules.fhsHelpers.enable = mkEnableOption "FHS compliant";
  config = mkIf cfg.enable {
    # TODO: add common FHSEnv
    programs.nix-ld.enable = true;
    services.envfs.enable = true;
  };
}
