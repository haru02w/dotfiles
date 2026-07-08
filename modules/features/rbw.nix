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
        };
      };
    };
}
