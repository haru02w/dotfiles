{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktopEnvironment;
in {
  options.modules.desktopEnvironment = {
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

  config = lib.mkMerge [
    (mkIf anyDEActive {services.xserver.enable = true;})
    (mkIf cfg.gnome.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.gnome.enable = true;
    })
    (mkIf cfg.kde.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.desktopManager.plasma6.enable = true;
    })
    (mkIf cfg.xfce.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.xfce.enable = true;
    })
    (mkIf cfg.pantheon.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.pantheon.enable = true;
    })
    (mkIf cfg.cinnamon.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.cinnamon.enable = true;
    })
    (mkIf cfg.mate.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.mate.enable = true;
    })
    (mkIf cfg.enlightenment.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.enlightenment.enable = true;
      services.acpid.enable = mkDefault true;
    })
    (mkIf cfg.lxqt.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.lxqt.enable = true;
    })
    (mkIf cfg.lumina.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.lumina.enable = true;
    })
    (mkIf cfg.budgie.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.budgie.enable = true;
    })
    (mkIf cfg.deepin.enable {
      services.xserver.enable = mkIf (!services.xserver.enable) true;
      services.xserver.desktopManager.deepin.enable = true;
    })
  ];
}
