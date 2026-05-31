{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module =
        { lib, ... }:
        {
          config.vim = {
            utility.snacks-nvim = {
              enable = true;
              setupOpts = {
                input.enabled = true;
                quickfile.enabled = true;
                bigfile.enabled = true;
                image.enabled = true;
                picker = {
                  enabled = true;
                  layout = {
                    preview = "main";
                    preset = "ivy";
                  };
                };
              };
            };

            pluginRC.snacks-toggles = lib.nvim.dag.entryAfter [ "snacks-nvim" ] ''
              Snacks.toggle.diagnostics():map("<leader>td")
              Snacks.toggle.inlay_hints():map("<leader>th")
            '';

            keymaps = [
              {
                mode = "n";
                key = "<leader>ff";
                action = "Snacks.picker.files";
                lua = true;
                desc = "Picker files";
              }
              {
                mode = "n";
                key = "<leader>fg";
                action = "Snacks.picker.grep";
                lua = true;
                desc = "Picker live grep";
              }
              {
                mode = [
                  "n"
                  "x"
                ];
                key = "<leader>fG";
                action = "Snacks.picker.grep_word";
                lua = true;
                desc = "Picker grep word";
              }
              {
                mode = "n";
                key = "<leader>fb";
                action = "Snacks.picker.buffers";
                lua = true;
                desc = "Picker buffers";
              }
              {
                mode = "n";
                key = "<leader>fd";
                action = "Snacks.picker.diagnostics";
                lua = true;
                desc = "Picker diagnostics";
              }
              {
                mode = "n";
                key = "<leader>fk";
                action = "Snacks.picker.keymaps";
                lua = true;
                desc = "Picker keymaps";
              }
              {
                mode = "n";
                key = "<leader>fq";
                action = "Snacks.picker.qflist";
                lua = true;
                desc = "Picker quickfix list";
              }
              {
                mode = "n";
                key = "<leader>fs";
                action = "Snacks.picker.lsp_symbols";
                lua = true;
                desc = "Picker LSP symbols";
              }
              {
                mode = "n";
                key = "<leader>fS";
                action = "Snacks.picker.lsp_workspace_symbols";
                lua = true;
                desc = "Picker LSP workspace symbols";
              }
              {
                mode = "n";
                key = "<leader>fu";
                action = "Snacks.picker.undo";
                lua = true;
                desc = "Picker undo history";
              }
              {
                mode = "n";
                key = "<leader>gg";
                action = "Snacks.lazygit.open";
                lua = true;
                desc = "Open lazygit";
              }
              {
                mode = "n";
                key = "<leader>lR";
                action = "Snacks.rename.rename_file";
                lua = true;
                desc = "Rename file";
              }
            ];

            extraPackages = with pkgs; [
              ripgrep
              lazygit
              ffmpeg
              ghostscript
            ];
          };
        };
    };
}
