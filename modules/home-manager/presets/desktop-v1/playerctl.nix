{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v1.playerctl;
in {
  options.modules.presets.desktop-v1.playerctl.enable =
    mkEnableOption "desktop-v1 playerctl";

  config = mkIf cfg.enable {
    services.playerctld.enable = true;
    services.mpris-proxy.enable = true;
  };
}
