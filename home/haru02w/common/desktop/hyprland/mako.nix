{config,...}:
{
  services.mako = with config.colorScheme.palette;{
    enable = true;
    ignoreTimeout = true;
    defaultTimeout = 5000;

    backgroundColor = "#${base00}FF";
    textColor = "#${base05}FF";
    borderColor = "#${base0D}FF";
  };
}
