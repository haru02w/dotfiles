{
  den.aspects.git.homeManager = {
    programs.git = {
      enable = true;
      signing.format = "ssh";
      settings = {
        pull.rebase = true;
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
