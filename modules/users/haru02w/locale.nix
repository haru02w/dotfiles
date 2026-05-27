{
  den.aspects.haru02w.nixos = {
    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "en_US.UTF-8";
    console.useXkbConfig = true;
    services.xserver.xkb = {
      layout = "us";
      options = "compose:ralt,altwin:swap_lalt_lwin,ctrl:nocaps";
    };
  };
}
