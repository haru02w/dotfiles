{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v2.playerctl;
in {
  options.modules.presets.desktop-v2.playerctl.enable =
    mkEnableOption "desktop-v2 playerctl";

  config = mkIf cfg.enable {
    services.playerctld.enable = true;
    services.mpris-proxy.enable = true;
  };
}
