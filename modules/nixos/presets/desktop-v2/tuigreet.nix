{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v2.tuigreet;
in {
  options.modules.presets.desktop-v2.tuigreet.enable =
    mkEnableOption "desktop-v2 tuigreet";

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --user-menu \
            --remember \
            --remember-user-session \
            --asterisks \
            --window-padding 1 \
            --container-padding 2 \
            --prompt-padding 2 \
            --cmd "sway"
          '';
          user = "greeter";
        };
      };
    };
  };
}
