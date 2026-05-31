{
  perSystem.nvf.module.config.vim = {
    utility.motion.flash-nvim = {
      enable = true;
      setupOpts.modes = {
        search.enabled = true;
        char.enabled = true;
      };
      mappings = {
        jump = null;
        treesitter = null;
        remote = null;
        toggle = null;
        treesitter_search = "/";
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "<leader>t/";
        action = "require('flash').toggle";
        lua = true;
        desc = "Toggle flash";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "require('flash').treesitter_search";
        lua = true;
        desc = "Flash treesitter search";
      }
    ];
  };
}
