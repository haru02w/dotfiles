{lib,...}:
with lib;
{
  options.desktop.wallpaper = mkOption {
    type = types.path;
    default = null;
    example = ./wallpaper.jpg;
  };
}
