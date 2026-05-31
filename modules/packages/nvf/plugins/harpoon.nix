{
  perSystem.nvf.module =
    { lib, ... }:
    let
      extraSelectKeys = lib.lists.genList (i: {
        idx = i + 5;
        key = if i + 5 == 10 then "0" else toString (i + 5);
      }) 6;
    in
    {
      config.vim = {
        navigation.harpoon = {
          enable = true;
          setupOpts = {
            save_on_toggle = true;
            sync_on_ui_close = true;
          };
          mappings = {
            listMarks = "<leader>`";
            file1 = "<leader>1";
            file2 = "<leader>2";
            file3 = "<leader>3";
            file4 = "<leader>4";
          };
        };

        lazy.plugins.harpoon.after = ''
          local harpoon = require('harpoon')
          local extensions = require('harpoon.extensions')
          harpoon:extend(extensions.builtins.highlight_current_file())
        '';

        keymaps = [
          {
            mode = "n";
            key = "<leader>A";
            action = "function() require('harpoon'):list():remove() end";
            lua = true;
            desc = "Remove harpoon mark";
          }
          {
            mode = "n";
            key = "<C-S-p>";
            action = "function() require('harpoon'):list():prev() end";
            lua = true;
            desc = "Harpoon previous mark";
          }
          {
            mode = "n";
            key = "<C-S-n>";
            action = "function() require('harpoon'):list():next() end";
            lua = true;
            desc = "Harpoon next mark";
          }
        ]
        ++ map (e: {
          mode = "n";
          key = "<leader>${e.key}";
          action = "function() require('harpoon'):list():select(${toString e.idx}) end";
          lua = true;
          desc = "Select harpoon mark ${toString e.idx}";
        }) extraSelectKeys;
      };
    };
}
