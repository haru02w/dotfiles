{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.displayManager;
in {
  options.modules.displayManager = {
    gdm.enable = mkEnableOption "GDM DM";
    sddm.enable = mkEnableOption "SDDM DM";
    lightdm.enable = mkEnableOption "SDDM DM";
  };

  config = lib.mkMerge [
    (mkIf cfg.gdm.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.displayManager.gdm.enable = true;
    })
    (mkIf cfg.sddm.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.displayManager.sddm.enable = true;
    })
    (mkIf cfg.lightdm.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.displayManager.lightdm.enable = true;
    })
  ];
}
