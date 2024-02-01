{lib,...}:
with lib;
{
  options.desktop.wallpaper = mkOption {
    type = types.nullOr types.path;
    default = null;
    example = ./wallpaper.jpg;
  };
}
