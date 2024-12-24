{lib, ...}:
with lib.nixvim; {
  plugins.navbuddy = {
    enable = true;

    lsp.autoAttach = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>ll";
      action = mkRaw "require('nvim-navbuddy').open";
      options = {
        silent = true;
        desc = "Open LSP NavBuddy";
      };
    }
  ];
}
