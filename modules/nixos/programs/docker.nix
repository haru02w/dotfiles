{ lib, config, ... }:
with lib;
let cfg = config.modules.programs.docker;
in {
  options.modules.programs.docker.enable = mkEnableOption "docker";
  config = mkIf cfg.enable {
    virtualisation.docker.enable = mkDefault true;
    environment.systemPackages = with pkgs; [ docker-compose ];
  };
}
