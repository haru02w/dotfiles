{ den, ... }: {
  den.aspects.nixvim.homeManager = { lib, pkgs, ... }: with lib.nixvim; {
    programs.nixvim = {
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
      };
      keymaps = [
        {
          key = "<leader>ff";
          mode = "n";
          action = mkRaw "Snacks.picker.files";
          options.desc = "Picker files";
        }
        {
          # Needs 'ripgrep'
          key = "<leader>fg";
          mode = "n";
          action = mkRaw "Snacks.picker.grep";
          options.desc = "Picker live grep";
        }
        {
          # Needs 'ripgrep'
          key = "<leader>fG";
          mode = [ "n" "x" ];
          action = mkRaw "Snacks.picker.grep_word";
          options.desc = "Picker live grep";
        }
        {
          key = "<leader>fb";
          mode = "n";
          action = mkRaw "Snacks.picker.buffers";
          options.desc = "Picker buffers";
        }
        {
          key = "<leader>fd";
          mode = "n";
          action = mkRaw "Snacks.picker.diagnostics";
          options.desc = "Picker diagnostics";
        }
        {
          key = "<leader>fk";
          mode = "n";
          action = mkRaw "Snacks.picker.keymaps";
          options.desc = "Picker keymaps";
        }
        {
          key = "<leader>fq";
          mode = "n";
          action = mkRaw "Snacks.picker.qflist";
          options.desc = "Picker quickfix list";
        }
        {
          key = "<leader>fs";
          mode = "n";
          action = mkRaw "Snacks.picker.lsp_symbols";
          options.desc = "Picker treesitter objects";
        }
        {
          key = "<leader>fS";
          mode = "n";
          action = mkRaw "Snacks.picker.lsp_workspace_symbols";
          options.desc = "Picker treesitter objects";
        }
        {
          key = "<leader>fu";
          mode = "n";
          action = mkRaw "Snacks.picker.undo";
          options.desc = "Picker undo history";
        }
        {
          key = "<leader>gg";
          mode = "n";
          action = mkRaw "Snacks.lazygit.open";
          options.desc = "Open lazygit";
        }
        {
          key = "<leader>lR";
          mode = "n";
          action = mkRaw "Snacks.rename.rename_file";
          options.desc = "Rename file";
        }
      ];
      extraConfigLua = ''
        Snacks.toggle.diagnostics():map("<leader>td")
        Snacks.toggle.inlay_hints():map("<leader>th")
      '';
      extraPackages = with pkgs; [
        ripgrep
      ];
    };
  };
}
