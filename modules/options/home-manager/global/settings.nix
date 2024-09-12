{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.settings;
in {
  options.modules.settings.enable = mkEnableOption "Home-Manager settings";
  config = mkIf cfg.enable {
    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };
}