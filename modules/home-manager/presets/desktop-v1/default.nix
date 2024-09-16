{ lib, config, ... }:
with lib;
let cfg = config.modules.presets.desktop-v1;
in {
  imports = [ ./hyprland.nix ];
  options.modules.presets.desktop-v1.enable =
    mkEnableOption "desktop-v1 preset";

  config = mkIf cfg.enable {
    modules.presets.desktop-v1.hyprland.enable = mkDefault true;
  };
}
