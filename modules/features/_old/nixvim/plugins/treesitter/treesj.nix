{ den, ... }:
{
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.treesj.enable = true;
    # adds <leader>m - toggle, <leader>j - join, <leader>s - split
  };
}
