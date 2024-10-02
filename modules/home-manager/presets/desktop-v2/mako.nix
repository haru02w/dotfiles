{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v2.mako;
in {
  options.modules.presets.desktop-v2.mako.enable =
    mkEnableOption "desktop-v2 mako";

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      ignoreTimeout = true;
      defaultTimeout = 5000;
    };
  };
}
