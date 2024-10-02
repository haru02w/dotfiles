{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.settings.security;
in {
  options.modules.settings.security.enable = mkOption {
    description = "Enable security options";
    default = true;
    type = types.bool;
  };

  config = mkIf cfg.enable {
    security = {
      pam.loginLimits = [
        {
          domain = "@users";
          item = "rtprio";
          type = "-";
          value = 1;
        }
      ];
      sudo.wheelNeedsPassword = false;
      rtkit.enable = true;
      polkit.enable = true;
      polkit.extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("network")) {
            return polkit.Result.YES;
          }
        });
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions")
          )
          {
            return polkit.Result.YES;
          }
        });
      '';
    };
  };
}
