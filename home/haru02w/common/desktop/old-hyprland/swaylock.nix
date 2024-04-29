{ config, pkgs, ... }: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -C ${config.xdg.configHome}/swaylock/config";
      }
    ];
    timeouts = [
      {
        timeout = 900;
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        timeout = 960;
        command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
  # TODO: extract it out
  programs.swaylock =
    {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        daemonize = true;
        show-failed-attempts = true;
        clock = true;
        screenshot = true;
        effect-blur = "15x15";
        effect-vignette = "1:1";
        color = "1f1d2e80";
        font = "Inter";
        indicator = true;
        indicator-radius = 200;
        indicator-thickness = 20;
        line-color = "1f1d2e";
        ring-color = "191724";
        inside-color = "1f1d2e";
        key-hl-color = "eb6f92";
        separator-color = "00000000";
        text-color = "e0def4";
        text-caps-lock-color = "";
        line-ver-color = "eb6f92";
        ring-ver-color = "eb6f92";
        inside-ver-color = "1f1d2e";
        text-ver-color = "e0def4";
        ring-wrong-color = "31748f";
        text-wrong-color = "31748f";
        inside-wrong-color = "1f1d2e";
        inside-clear-color = "1f1d2e";
        text-clear-color = "e0def4";
        ring-clear-color = "9ccfd8";
        line-clear-color = "1f1d2e";
        line-wrong-color = "1f1d2e";
        bs-hl-color = "31748f";
        grace = 2;
        grace-no-mouse = true;
        grace-no-touch = true;
        datestr = "%a, %B %e";
        timestr = "%I:%M %p";
        fade-in = 0.3;
        ignore-empty-password = true;
      };
    };
}
