{ lib, config, inputs, pkgs, ... }:
with lib;
let cfg = config.modules.presets.desktop-v1.hyprland;
in {
  options.modules.presets.desktop-v1.hyprland.enable =
    mkEnableOption "desktop-v1 hyprland";

  config = mkIf cfg.enable {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      plugins = with inputs; [ hyprsplit.packages.${pkgs.system}.hyprsplit ];
    };
    # wayland.windowManager.hyprland.settings = {};
  };
}
