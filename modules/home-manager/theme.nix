{ lib, config, ... }:
let
  mkFontOption = kind:
    with lib; {
      family = mkOption {
        type = types.str;
        default = null;
        description = "Family name for ${kind} font profile";
        example = "Fira Code Nerd Font";
      };
      package = mkOption {
        type = types.package;
        default = null;
        description = "Package for ${kind} font profile";
        example = "pkgs.fira-code";
      };
    };
  cfg = config.fontProfiles;
in
{
  options = {
    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      example = ../image.jpg;
    };
    fontProfiles = {
      enable = lib.mkEnableOption "Whether to enable font profiles";
      monospace = mkFontOption "monospace";
      regular = mkFontOption "regular";
    };
  };
  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;
    home.packages = [ cfg.monospace.package cfg.regular.package ];
  };
}
