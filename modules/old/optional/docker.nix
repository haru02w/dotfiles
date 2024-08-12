{ lib, config, ... }:
with lib;
let cfg = config.modules.docker;
in {
  options.modules.docker.enable = mkEnableOption "docker";
  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [ docker-compose ];
  };
}
