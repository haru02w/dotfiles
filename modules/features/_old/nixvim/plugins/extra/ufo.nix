{ den, ... }: {
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.nvim-ufo.enable = true;
  };
}
