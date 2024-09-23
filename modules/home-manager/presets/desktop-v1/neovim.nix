{
  lib,
  config,
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
      packages = [pkgs.neovim];
      sessionVariables.EDITOR = "nvim";
    };
  };
}
