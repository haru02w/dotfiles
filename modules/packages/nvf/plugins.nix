{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim = {
        # claude-agent-acp binary for avante's claude-code ACP provider.
        extraPackages = [ pkgs.claude-agent-acp ];

        assistant = {
          avante-nvim = {
            enable = true;
            setupOpts = {
              # Drive Claude Code via ACP (claude-agent-acp) instead of the
              # direct Anthropic API, so auth uses the claude CLI subscription
              # and no ANTHROPIC_API_KEY is needed. Runs with bypassPermissions.
              provider = "claude-code";
              # native input provider calls vim.ui.select (wrong fn/signature),
              # crashing with snacks' vim.ui.select override. snacks provider
              # uses Snacks.input correctly.
              input.provider = "snacks";
            };
          };
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
