{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.sops;
in {
  options.modules.programs.sops.enable = mkEnableOption "sops";
  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../secrets/accounts.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = mkDefault "/${config.home.homeDirectory}/.config/sops/age/keys.txt";

      secrets."ssh/key" = {
        sopsFile = ../../../secrets/secrets.yaml;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };

      secrets."ssh/pub" = {
        sopsFile = ../../../secrets/secrets.yaml;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };
    };
  };
}
