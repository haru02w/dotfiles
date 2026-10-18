{
  perSystem =
    { pkgs, ... }:
    {
      nixvim.module =
        let
          mkKey = mode: key: action: desc: {
            inherit mode key;
            action.__raw = action;
            options.desc = desc;
          };
        in
        {
          # claude-agent-acp binary for avante's claude-code ACP provider.
          extraPackages = [ pkgs.claude-agent-acp ];

          plugins = {
            avante = {
              enable = true;
              settings = {
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
            # codecompanion.enable = true;
            # neocodeium.enable = true;
            # supermaven.enable = true;

            nvim-autopairs.enable = true;

            which-key.enable = true;

            dap.enable = true;
            dap-ui.enable = true;

            gitsigns.enable = true;
            hunk.enable = true;

            todo-comments.enable = true;

            neocord.enable = true;

            conjure.enable = true;

            lualine.enable = true;

            fidget.enable = true;
          };

          # Open/close dap-ui with debug sessions (nvf did this by default).
          extraConfigLua = ''
            do
              local dap, dapui = require('dap'), require('dapui')
              dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
              dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
              dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
            end
          '';

          # nvf's default nvim-dap and gitsigns mappings.
          keymaps = [
            (mkKey "n" "<leader>dc" "function() require('dap').continue() end" "Continue")
            (mkKey "n" "<leader>dR" "function() require('dap').restart() end" "Restart")
            (mkKey "n" "<leader>dq" "function() require('dap').terminate() end" "Terminate")
            (mkKey "n" "<leader>d." "function() require('dap').run_last() end" "Re-run last debug session")
            (mkKey "n" "<leader>dr" "function() require('dap').repl.toggle() end" "Toggle repl")
            (mkKey "n" "<leader>dh" "function() require('dap.ui.widgets').hover() end" "Hover")
            (mkKey "n" "<leader>db" "function() require('dap').toggle_breakpoint() end" "Toggle breakpoint")
            (mkKey "n" "<leader>dgc" "function() require('dap').run_to_cursor() end"
              "Continue to the current cursor"
            )
            (mkKey "n" "<leader>dgi" "function() require('dap').step_into() end" "Step into function")
            (mkKey "n" "<leader>dgo" "function() require('dap').step_out() end" "Step out of function")
            (mkKey "n" "<leader>dgj" "function() require('dap').step_over() end" "Next step")
            (mkKey "n" "<leader>dgk" "function() require('dap').step_back() end" "Step back")
            (mkKey "n" "<leader>dvo" "function() require('dap').up() end" "Go up stacktrace")
            (mkKey "n" "<leader>dvi" "function() require('dap').down() end" "Go down stacktrace")
            (mkKey "n" "<leader>du" "function() require('dapui').toggle() end" "Toggle DAP UI")

            (mkKey "n" "]c" "function() require('gitsigns').nav_hunk('next') end" "Next hunk")
            (mkKey "n" "[c" "function() require('gitsigns').nav_hunk('prev') end" "Previous hunk")
            (mkKey "n" "<leader>hs" "function() require('gitsigns').stage_hunk() end" "Stage hunk")
            (mkKey "n" "<leader>hr" "function() require('gitsigns').reset_hunk() end" "Reset hunk")
            (mkKey "n" "<leader>hS" "function() require('gitsigns').stage_buffer() end" "Stage buffer")
            (mkKey "n" "<leader>hR" "function() require('gitsigns').reset_buffer() end" "Reset buffer")
            (mkKey "n" "<leader>hP" "function() require('gitsigns').preview_hunk() end" "Preview hunk")
            (mkKey "n" "<leader>hb" "function() require('gitsigns').blame_line({ full = true }) end"
              "Blame line"
            )
            (mkKey "n" "<leader>tb" "function() require('gitsigns').toggle_current_line_blame() end"
              "Toggle blame"
            )
            (mkKey "n" "<leader>hd" "function() require('gitsigns').diffthis() end" "Diff this")
            (mkKey "n" "<leader>hD" "function() require('gitsigns').diffthis('~') end" "Diff project")
          ];
        };
    };
}
