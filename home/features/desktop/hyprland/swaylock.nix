{config, pkgs, ...}:
{
  services.swayidle = {
    enable = true;
    events = [
      {event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock";}
    ];
    timeouts = [
      {
        timeout = 900; 
        command = "${pkgs.swaylock}/bin/swaylock;${
            if config.wayland.windowManager.hyprland.enable then
            "${pkgs.hyprland}/bin/hyprctl dispatch dpms off"
            else null}";
        resumeCommand = "${
          if config.wayland.windowManager.hyprland.enable then
            "${pkgs.hyprland}/bin/hyprctl dispatch dpms on"
          else null}";
      }
    ];
  };
  # TODO: extract it out
  programs.swaylock = let
    wallpaper = ./../../dotconfig/wallpapers/localhost.jpeg;
  in
  {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = "${wallpaper}";
      ignore-empty-password = true;
      indicator = true;
      indicator-idle-visible = true;
      indicator-caps-lock = true;
      indicator-radius = 100;
      indicator-thickness = 16;
      line-uses-inside = true;
      effect-blur = "9x7";
      effect-vignette = "0.85:0.85";
      fade-in = 0.1;
    };
  };
}
