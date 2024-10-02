{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v2.neovim;
in {
  options.modules.presets.desktop-v2.neovim.enable =
    mkEnableOption "desktop-v2 neovim";

  config = mkIf cfg.enable {
    home = {
      packages = [pkgs.neovim];
      sessionVariables.EDITOR = "nvim";
    };
  };
}
