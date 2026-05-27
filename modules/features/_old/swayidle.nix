{ den, ... }:
{
  den.aspects.swayidle.homeManager =
    {
      config,
      lib,
      ...
    }:
    {
      services.swayidle = {
        enable = true;
        systemdTargets = [ "graphical-session.target" ];
        events = {
          "before-sleep" = "${lib.getExe config.programs.swaylock.package} -efF";
        };
        timeouts = [
          {
            timeout = 900;
            command = "${lib.getExe config.wayland.windowManager.sway.package} -efF";
          }
          {
            timeout = 960;
            command = "${lib.getExe' config.wayland.windowManager.sway.package "swaymsg"} 'output * dpms off'";
            resumeCommand = "${lib.getExe' config.wayland.windowManager.sway.package "swaymsg"} 'output * dpms on'";
          }
        ];
      };
    };
}
