{pkgs, ...}:
{
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
          --cmd "Hyprland > /dev/null"
        '';
        user = "greeter";
      };
    };
  };
}
