{
  perSystem =
    { pkgs, ... }:
    {
      nixvim.module = {
        plugins.snacks = {
          enable = true;
          settings = {
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
          luaConfig.post = ''
            Snacks.toggle.diagnostics():map("<leader>td")
            Snacks.toggle.inlay_hints():map("<leader>th")
          '';
        };

        keymaps = [
          {
            mode = "n";
            key = "<leader>ff";
            action.__raw = "function() Snacks.picker.files() end";
            options.desc = "Picker files";
          }
          {
            mode = "n";
            key = "<leader>fg";
            action.__raw = "function() Snacks.picker.grep() end";
            options.desc = "Picker live grep";
          }
          {
            mode = [
              "n"
              "x"
            ];
            key = "<leader>fG";
            action.__raw = "function() Snacks.picker.grep_word() end";
            options.desc = "Picker grep word";
          }
          {
            mode = "n";
            key = "<leader>fb";
            action.__raw = "function() Snacks.picker.buffers() end";
            options.desc = "Picker buffers";
          }
          {
            mode = "n";
            key = "<leader>fd";
            action.__raw = "function() Snacks.picker.diagnostics() end";
            options.desc = "Picker diagnostics";
          }
          {
            mode = "n";
            key = "<leader>fk";
            action.__raw = "function() Snacks.picker.keymaps() end";
            options.desc = "Picker keymaps";
          }
          {
            mode = "n";
            key = "<leader>fq";
            action.__raw = "function() Snacks.picker.qflist() end";
            options.desc = "Picker quickfix list";
          }
          {
            mode = "n";
            key = "<leader>fs";
            action.__raw = "function() Snacks.picker.lsp_symbols() end";
            options.desc = "Picker LSP symbols";
          }
          {
            mode = "n";
            key = "<leader>fS";
            action.__raw = "function() Snacks.picker.lsp_workspace_symbols() end";
            options.desc = "Picker LSP workspace symbols";
          }
          {
            mode = "n";
            key = "<leader>fu";
            action.__raw = "function() Snacks.picker.undo() end";
            options.desc = "Picker undo history";
          }
          {
            mode = "n";
            key = "<leader>gg";
            action.__raw = "function() Snacks.lazygit.open() end";
            options.desc = "Open lazygit";
          }
          {
            mode = "n";
            key = "<leader>lR";
            action.__raw = "function() Snacks.rename.rename_file() end";
            options.desc = "Rename file";
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
}
