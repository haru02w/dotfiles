{ den, ... }:
{
  den.aspects.greetd.nixos =
    { pkgs, ... }:
    {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = ''
              ${pkgs.tuigreet}/bin/tuigreet \
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
