{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.security;
in {
  options.modules.security.enable = mkOption {
    description = "Enable security options";
    default = config.modules.settings.enable;
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
      sudo.wheelNeedsPassword = mkDefault false;
      rtkit.enable = mkDefault true;
      polkit.enable = mkDefault true;
      polkit.extraConfig = mkDefault ''
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
