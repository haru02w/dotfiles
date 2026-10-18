{
  perSystem.nixvim.module =
    { lib, ... }:
    let
      selectKeys = lib.lists.genList (i: {
        idx = i + 1;
        key = if i + 1 == 10 then "0" else toString (i + 1);
      }) 10;
    in
    {
      plugins.harpoon = {
        enable = true;
        settings.settings = {
          save_on_toggle = true;
          sync_on_ui_close = true;
        };
        luaConfig.post = ''
          local harpoon = require('harpoon')
          local extensions = require('harpoon.extensions')
          harpoon:extend(extensions.builtins.highlight_current_file())
        '';
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader>a";
          action.__raw = "function() require('harpoon'):list():add() end";
          options.desc = "Add harpoon mark";
        }
        {
          mode = "n";
          key = "<leader>`";
          action.__raw = "function() local h = require('harpoon'); h.ui:toggle_quick_menu(h:list()) end";
          options.desc = "List harpoon marks";
        }
        {
          mode = "n";
          key = "<leader>A";
          action.__raw = "function() require('harpoon'):list():remove() end";
          options.desc = "Remove harpoon mark";
        }
        {
          mode = "n";
          key = "<C-S-p>";
          action.__raw = "function() require('harpoon'):list():prev() end";
          options.desc = "Harpoon previous mark";
        }
        {
          mode = "n";
          key = "<C-S-n>";
          action.__raw = "function() require('harpoon'):list():next() end";
          options.desc = "Harpoon next mark";
        }
      ]
      ++ map (e: {
        mode = "n";
        key = "<leader>${e.key}";
        action.__raw = "function() require('harpoon'):list():select(${toString e.idx}) end";
        options.desc = "Select harpoon mark ${toString e.idx}";
      }) selectKeys;
    };
}
