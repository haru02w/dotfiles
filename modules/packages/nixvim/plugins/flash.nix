{
  perSystem.nixvim.module = {
    plugins.flash = {
      enable = true;
      settings.modes = {
        search.enabled = true;
        char.enabled = true;
      };
    };

    keymaps = [
      {
        mode = [
          "x"
          "o"
        ];
        key = "/";
        action.__raw = "function() require('flash').treesitter_search() end";
        options.desc = "Flash treesitter search";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "<leader>t/";
        action.__raw = "function() require('flash').toggle() end";
        options.desc = "Toggle flash";
      }
      {
        mode = "n";
        key = "<leader>/";
        action.__raw = "function() require('flash').treesitter_search() end";
        options.desc = "Flash treesitter search";
      }
    ];
  };
}
