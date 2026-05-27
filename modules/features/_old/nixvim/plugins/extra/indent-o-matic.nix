{ den, ... }: {
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.indent-o-matic.enable = true;
  };
}
