let
  name = "haru02w";
  email = "joaovictormillane@gmail.com";
in
{
  den.aspects.git.homeManager = {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = { inherit name email; };
      };
    };
    programs.git = {
      enable = true;
      signing.format = "ssh";
      settings = {
        pull.rebase = true;
        user = { inherit name email; };
      };
    };
    # programs.delta = {
    #   enable = true;
    #   options = {
    #     line-numbers = true;
    #     side-by-side = false;
    #   };
    # };
  };
}
