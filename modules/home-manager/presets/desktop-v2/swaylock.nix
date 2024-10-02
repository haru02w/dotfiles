{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) getExe getExe';
  cfg = config.modules.presets.desktop-v2.swaylock;
in {
  options.modules.presets.desktop-v2.swaylock = {
    enable = lib.mkEnableOption "Enable Swaylock";
  };

  config = lib.mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        indicator = true;
        indicator-radius = 128;

        daemonize = true;
        font-size = 48;

        clock = true;
        datestr = "%a, %B %e";
        timestr = "%H:%M %p";

        fade-in = 1;
        effect-blur = "15x15";
        effect-vignette = "1:1";
      };
    };
    services.swayidle = {
      enable = true;
      systemdTarget = "graphical-session.target";
      events = [
        {
          event = "before-sleep";
          command = "${getExe config.programs.swaylock.package} -efF";
        }
      ];
      timeouts = [
        {
          timeout = 900;
          command = "${getExe config.wayland.windowManager.sway.package} -efF";
        }
        {
          timeout = 960;
          command = "${getExe' config.wayland.windowManager.sway.package "swaymsg"} 'output * dpms off'";
          resumeCommand = "${getExe' config.wayland.windowManager.sway.package "swaymsg"} 'output * dpms on'";
        }
      ];
    };
  };
}
