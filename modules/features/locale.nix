{
  den.aspects.locale.nixos =
    { config, ... }:
    {
      time.timeZone = "America/Sao_Paulo";
      i18n.defaultLocale = "en_US.UTF-8";
      console.useXkbConfig = true;
      services.xserver.xkb = {
        layout = "us";
        options = "compose:ralt,altwin:swap_lalt_lwin,ctrl:nocaps";
      };
      environment.sessionVariables = {
        XKB_DEFAULT_LAYOUT = config.services.xserver.xkb.layout;
        XKB_DEFAULT_OPTIONS = config.services.xserver.xkb.options;
      };
    };
}
