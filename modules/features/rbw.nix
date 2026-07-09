{
  den.aspects.rbw.homeManager =
    { pkgs, ... }:
    {
      programs.rbw = {
        enable = true;
        settings = {
          email = "joaovictormillane@gmail.com";
          base_url = "https://bw.haru02w.eu.org";
          pinentry = pkgs.pinentry-curses;
          lock_timeout = 7200; # 2h
        };
      };

      # rbw-agent has a built-in SSH agent that signs auth challenges using
      # "SSH Key" vault items. Point SSH clients at its socket.
      home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
    };
}
