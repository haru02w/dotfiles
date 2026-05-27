{ den, ... }: {
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.which-key.enable = true;
  };
}
