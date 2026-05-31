{ den, ... }:
{
  den.aspects.nixvim.homeManager =
    { lib, ... }:
    with lib.nixvim;
    {
      programs.nixvim = {
        plugins.flash = {
          enable = true;
          settings = {
            modes = {
              search.enabled = true;
              char.enabled = true;
            };
          };
        };
        keymaps = [
          {
            key = "<leader>t/";
            mode = [
              "n"
              "x"
              "o"
            ];
            action = mkRaw "require('flash').toggle";
            options = {
              silent = true;
              desc = "flash";
            };
          }
          {
            key = "/";
            mode = [
              "o"
              "x"
            ];
            action = mkRaw "require('flash').treesitter_search";
            options = {
              silent = true;
              desc = "flash";
            };
          }
          {
            key = "<leader>/";
            mode = "n";
            action = mkRaw "require('flash').treesitter_search";
            options = {
              silent = true;
              desc = "flash";
            };
          }
        ];
      };
    };
}
