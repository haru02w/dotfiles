{
  den.aspects.direnv.homeManager = {
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    home.sessionVariables.DIRENV_LOG_FORMAT = "";
  };
}
