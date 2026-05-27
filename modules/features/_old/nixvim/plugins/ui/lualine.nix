{ den, ... }: {
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.lualine.enable = true;
  };
}
