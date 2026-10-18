{
  perSystem.nixvim.module = {
    plugins.treesj = {
      enable = true;
      settings.use_default_keymaps = false;
      lazyLoad.settings.cmd = [
        "TSJToggle"
        "TSJSplit"
        "TSJJoin"
      ];
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>m";
        action = "<cmd>TSJToggle<CR>";
        options.desc = "Treesj toggle";
      }
      {
        mode = "n";
        key = "<leader>j";
        action = "<cmd>TSJJoin<CR>";
        options.desc = "Treesj join";
      }
      {
        mode = "n";
        key = "<leader>s";
        action = "<cmd>TSJSplit<CR>";
        options.desc = "Treesj split";
      }
    ];
  };
}
