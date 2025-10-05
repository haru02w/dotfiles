{
  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true; # use xkb.options in tty.

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    options = "compose:ralt,altwin:swap_lalt_lwin,ctrl:nocaps";
  };
}
