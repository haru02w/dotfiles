{ lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.hyprland;
in {
  options.modules.desktop.hyprland.enable = true;
  config = mkIf cfg.enable {

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.package.${pkgs.system}.hyprland;
    };

    xdg.portal.enable = true;

    security.pam.services.swaylock = { };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    hardware.opengl = let
      hypr-pkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.system};
    in {
      package = hypr-pkgs.mesa.drivers;

      # if you also want 32-bit support (e.g for Steam)
      driSupport32Bit = true;
      package32 = hypr-pkgs.pkgsi686Linux.mesa.drivers;
    };
  };
}
