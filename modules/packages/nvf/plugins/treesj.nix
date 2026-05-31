{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim = {
        lazy.plugins.treesj = {
          package = pkgs.vimPlugins.treesj;
          setupModule = "treesj";
          setupOpts = { };
          cmd = [
            "TSJToggle"
            "TSJSplit"
            "TSJJoin"
          ];
          keys = [
            {
              mode = "n";
              key = "<leader>m";
              action = "<cmd>TSJToggle<CR>";
              desc = "Treesj toggle";
            }
            {
              mode = "n";
              key = "<leader>j";
              action = "<cmd>TSJJoin<CR>";
              desc = "Treesj join";
            }
            {
              mode = "n";
              key = "<leader>s";
              action = "<cmd>TSJSplit<CR>";
              desc = "Treesj split";
            }
          ];
        };
      };
    };
}
