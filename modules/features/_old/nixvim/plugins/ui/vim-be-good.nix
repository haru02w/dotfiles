{ den, ... }:
{
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.vim-be-good.enable = true;
  };
}
