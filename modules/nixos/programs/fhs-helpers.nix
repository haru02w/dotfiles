{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.fhs-helpers;
in {
  options.modules.fhs-helpers.enable = mkEnableOption "FHS compliant";
  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
    services.envfs.enable = true;
    environment.systemPackages = [
      nix-alien
    ];
  };
}
