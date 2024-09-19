{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v1.neovim;
in {
  options.modules.presets.desktop-v1.neovim.enable =
    mkEnableOption "desktop-v1 neovim";

  config = mkIf cfg.enable {
    home = {
      packages = [inputs.nixnvc.packages.${pkgs.system}.default];
      sessionVariables.EDITOR = "nvim";
    };
  };
}
