{lib, config, pkgs, ...}:
with lib;
let cfg = config.modules.desktops.kde;
in {
  options.modules.desktops.kde.enable = mkEnableOption "Plasma DE";
  config = mkIf cfg.enable {
    services.xserver.enable = mkForce true;
    services.desktopManager.plasma6.enable = mkDefault true;
  };
}

