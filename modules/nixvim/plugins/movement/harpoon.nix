{lib, ...}:
with lib.nixvim; let
  from0to9 = attr: builtins.genList (i: attr i) 10;
  mod = a: b: a - (b * (a / b));
in {
  plugins.harpoon = {
    enable = true;
    settings = {
      settings = {
        save_on_toggle = true;
        sync_on_ui_close = true;
      };
    };
  };

  keymaps =
    [
      {
        mode = "n";
        key = "<leader>a";
        action = mkRaw "function() require('harpoon'):list():add() end";
        options.desc = "Add harpoon mark";
      }
      {
        mode = "n";
        key = "<leader>A";
        action = mkRaw "function() require('harpoon'):list():remove() end";
        options.desc = "Remove harpoon marks";
      }
      {
        mode = "n";
        key = "<leader>`";
        action = mkRaw ''          function()
                  require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
                end'';
        options.desc = "Open harpoon list";
      }
      {
        mode = "n";
        key = "<C-S-p>";
        action = mkRaw ''function() require('harpoon'):list():prev() end'';
        options.desc = "Select harpoon previous mark";
      }
      {
        mode = "n";
        key = "<C-S-n>";
        action = mkRaw ''function() require('harpoon'):list():next() end'';
        options.desc = "Select harpoon next mark";
      }
    ]
    ++ from0to9 (i: {
      mode = "n";
      key = "<leader>${toString (mod (i + 1) 10)}";
      action = mkRaw ''function() require('harpoon'):list():select(${toString (i + 1)}) end'';
      options.desc = "Select harpoon mark ${toString (i + 1)}";
    });

  extraConfigLua = ''
    local harpoon = require('harpoon')
    local extensions = require('harpoon.extensions')
    harpoon:extend(extensions.builtins.highlight_current_file())
  '';
}
