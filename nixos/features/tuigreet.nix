{ pkgs, config, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "Hyprland > /dev/null";
        user = "${config.users.main_user}";
      };
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
