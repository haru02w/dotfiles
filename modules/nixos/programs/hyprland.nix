{ lib, config, inputs, pkgs, ... }:
with lib;
let cfg = config.modules.programs.hyprland;
in {
  options.modules.programs.hyprland.enable = mkEnableOption "Hyprland";
  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
