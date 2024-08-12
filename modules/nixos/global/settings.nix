{ lib, config, ... }:
with lib;
let cfg = config.modules.settings;
in {
  options.modules.settings = with types; {
    hostname = mkOption { type = str; example = "mycomputer"; };
    locale = mkOption { type = str; example = "en_US.UTF-8"; };
    timezone = mkOption { type = str; example = "America/Sao_Paulo"; };
  };
  config = {
    networking.hostName = cfg.hostname;
    networking.networkmanager.enable = mkDefault true;
    i18n = {
      defaultLocale = cfg.locale;
      extraLocaleSettings = {
        LC_ADDRESS = cfg.locale;
        LC_IDENTIFICATION = cfg.locale;
        LC_MEASUREMENT = cfg.locale;
        LC_MONETARY = cfg.locale;
        LC_NAME = cfg.locale;
        LC_NUMERIC = cfg.locale;
        LC_PAPER = cfg.locale;
        LC_TELEPHONE = cfg.locale;
        LC_TIME = cfg.locale;
      };
    };
    time.timeZone = cfg.timezone;
  };
}
