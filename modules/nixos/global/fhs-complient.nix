{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.fhs-compliant;
in {
  options.modules.fhs-compliant.enable = mkEnableOption "FHS compliant";
  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
    environment.systemPackages = [
      nix-alien
    ];
  };
}
