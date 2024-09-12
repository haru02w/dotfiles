{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.neovim;
in {
  options.modules.programs.neovim = {
    enable = mkEnableOption "neovim";
    package = lib.mkPackageOption pkgs "neovim";
  };
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = mkDefault true;
      defaultEditor = mkDefault true;
      viAlias = mkDefault true;
      vimAlias = mkDefault true;
      configure.customRC = mkDefault ''
        set number relativenumber
      '';
    };
  };
}
