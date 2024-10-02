{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v2.udiskie;
in {
  options.modules.presets.desktop-v2.udiskie.enable =
    mkEnableOption "desktop-v2 udiskie";

  config = mkIf cfg.enable {
    # Enable automounting in /run/media/$USER/
    # OBS: The following option at nixos config must be enabled
    # 'services.udisks2.enable = true'
    services.udiskie = {
      enable = true;
      tray = "auto";
      notify = true;
      automount = true;
      settings = {
        device_config = [
          {
            id_label = "VTOYEFI";
            ignore = true;
          }
        ];
      };
    };
  };
}
