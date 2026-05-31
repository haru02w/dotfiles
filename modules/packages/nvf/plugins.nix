{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim = {
        assistant = {
          avante-nvim.enable = true;
          # codecompanion-nvim.enable = true;
          # neocodeium.enable = true;
          # supermaven-nvim.enable = true;
        };

        autopairs.nvim-autopairs.enable = true;

        binds.whichKey.enable = true;

        debugger.nvim-dap = {
          enable = true;
          ui.enable = true;
        };

        git = {
          gitsigns.enable = true;
          hunk-nvim.enable = true;
        };

        notes.todo-comments.enable = true;

        presence.neocord.enable = true;

        repl.conjure.enable = true;

        statusline.lualine.enable = true;

        ui = {
          nvim-ufo.enable = true;
        };

        visuals.fidget-nvim.enable = true;
      };
    };
}
