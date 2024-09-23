{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;

    nixvimInjections = true;

    folding = true;
    settings = {
      indent.enable = true;
      highlight.enable = true;
      incremental_selection = {
        enable = true;
        keymaps = {
          init_selection = "<C-b>"; # set to `false` to disable one of the mappings
          node_incremental = "<C-b>";
          scope_incremental = false;
          node_decremental = "<bs>";
        };
      };
    };
  };
}
