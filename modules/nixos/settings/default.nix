{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.settings;
in {
  imports = [
    ./security.nix
    ./nix.nix
  ];
  options.modules.settings = with types; {
    enable = mkEnableOption "NixOS settings";
    hostname = mkOption {
      type = str;
      example = "mycomputer";
    };
    keymap = {
      layout = mkOption {
        type = str;
        default = "us";
        example = "us";
      };
      variant = mkOption {
        type = str;
        default = "";
      };
      options = mkOption {
        type = str;
        default = "";
      };
    };
    locale = mkOption {
      type = str;
      example = "en_US.UTF-8";
    };
    timezone = mkOption {
      type = str;
      example = "America/Sao_Paulo";
    };
  };
  config = mkIf cfg.enable {
    networking.hostName = cfg.hostname;
    networking.networkmanager.enable = true;

    services.xserver.xkb = {
      layout = cfg.keymap.layout;
      variant = cfg.keymap.variant;
      options = cfg.keymap.options;
    };
    console.useXkbConfig = true;

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
