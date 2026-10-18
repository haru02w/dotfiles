{
  perSystem.nixvim.module.plugins = {
    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      # built-in treesitter folding (vim.treesitter.foldexpr)
      folding.enable = true;
    };
    #treesitter-context.enable = true;
    treesitter-textobjects.enable = true;
  };
}
