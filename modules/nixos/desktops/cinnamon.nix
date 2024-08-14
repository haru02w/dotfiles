{lib, config, pkgs, ...}:
with lib;
let cfg = config.modules.desktops.cinnamon;
in {
  options.modules.desktops.cinnamon.enable = mkEnableOption "Cinnamon DE";
  config = mkIf cfg.enable {
    services.xserver.enable = mkForce true;
    services.xserver.desktopManager.cinnamon.enable = mkDefault true;
  };
}

