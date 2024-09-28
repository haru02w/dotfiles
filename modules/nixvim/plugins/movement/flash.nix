{lib, ...}:
with lib.nixvim; {
  plugins.flash = {
    enable = true;
    settings = {
      jump.autojump = true;
      modes.search.enabled = true;
    };
  };
  keymaps = [
    {
      key = "s";
      mode = ["n" "x" "o"];
      action = mkRaw "require('flash').jump";
      options = {
        silent = true;
        desc = "flash";
      };
    }
    {
      key = "S";
      mode = ["n" "x" "o"];
      action = mkRaw "require('flash').treesitter";
      options = {
        silent = true;
        desc = "flash";
      };
    }
    {
      key = "r";
      mode = "o";
      action = mkRaw "require('flash').remote";
      options = {
        silent = true;
        desc = "flash";
      };
    }
    {
      key = "R";
      mode = ["o" "x"];
      action = mkRaw "require('flash').treesitter_search";
      options = {
        silent = true;
        desc = "flash";
      };
    }
  ];
}
# TODO:

