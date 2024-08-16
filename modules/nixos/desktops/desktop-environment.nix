{ lib, config, ... }:
with lib;
let cfg = config.modules.desktops;
in {
  options.modules.desktops = {
    gnome.enable = mkEnableOption "Gnome DE";
    kde.enable = mkEnableOption "Plasma DE";
    xfce.enable = mkEnableOption "XFCE DE";
    pantheon.enable = mkEnableOption "Pantheon DE";
    cinnamon.enable = mkEnableOption "Cinnamon DE";
    mate.enable = mkEnableOption "Mate DE";
    enlightenment.enable = mkEnableOption "Enlightenment DE";
    lxqt.enable = mkEnableOption "LXQT DE";
    lumina.enable = mkEnableOption "Lumina DE";
    budgie.enable = mkEnableOption "Budgie DE";
    deepin.enable = mkEnableOption "Deepin DE";
  };

  config = let
    anyDEActive = lib.any (value: value == true)
      (map (name: cfg.${name}.enable) (builtins.attrNames cfg));
  in lib.mkMerge [
    (mkIf anyDEActive { services.xserver.enable = mkForce true; })
    (mkIf cfg.gnome.enable {
      services.xserver.desktopManager.gnome.enable = mkForce true;
    })
    (mkIf cfg.kde.enable {
      services.desktopManager.plasma6.enable = mkForce true;
    })
    (mkIf cfg.xfce.enable {
      services.xserver.desktopManager.xfce.enable = mkForce true;
    })
    (mkIf cfg.pantheon.enable {
      services.xserver.desktopManager.pantheon.enable = mkForce true;
    })
    (mkIf cfg.cinnamon.enable {
      services.xserver.desktopManager.cinnamon.enable = mkForce true;
    })
    (mkIf cfg.mate.enable {
      services.xserver.desktopManager.mate.enable = mkForce true;
    })
    (mkIf cfg.enlightenment.enable {
      services.xserver.desktopManager.enlightenment.enable = mkForce true;
      services.acpid.enable = mkDefault true;
    })
    (mkIf cfg.lxqt.enable {
      services.xserver.desktopManager.lxqt.enable = mkForce true;
    })
    (mkIf cfg.lumina.enable {
      services.xserver.desktopManager.lumina.enable = mkForce true;
    })
    (mkIf cfg.budgie.enable {
      services.xserver.desktopManager.budgie.enable = mkForce true;
    })
    (mkIf cfg.deepin.enable {
      services.xserver.desktopManager.deepin.enable = mkForce true;
    })
  ];
}
