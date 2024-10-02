{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.docker;
in {
  options.modules.programs.docker.enable = mkEnableOption "docker";
  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [docker-compose];
  };
}
