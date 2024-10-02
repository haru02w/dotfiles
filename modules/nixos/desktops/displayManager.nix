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

  config = let
    anyDMActive =
      lib.any (value: value == true) (map (name: cfg.${name}.enable) (builtins.attrNames cfg));
  in
    lib.mkMerge [
      (mkIf anyDMActive {services.xserver.enable = mkDefault true;})
      (mkIf cfg.gdm.enable {
        services.xserver.displayManager.gdm.enable = true;
      })
      (mkIf cfg.sddm.enable {
        services.displayManager.sddm.enable = true;
      })
      (mkIf cfg.lightdm.enable {
        services.xserver.displayManager.lightdm.enable = true;
      })
    ];
}
