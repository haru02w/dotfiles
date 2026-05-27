{
  den.aspects.ly.nixos.services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      # fix dumb tty not eval anything
      login_cmd = ''stty sane; exec "$@"'';
    };
  };
}
