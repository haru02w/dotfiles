{
  pkgs,
  lib,
  ...
}:
with lib.nixvim; {
  extraPlugins = [pkgs.vimPlugins.grapple-nvim];
  extraConfigLua = ''
    local grapple = require('grapple')
    grapple.setup({
      -- scope = "git_branch",
      icons = false,
    })
  '';
  keymaps =
    [
      {
        mode = "n";
        key = "<leader>m";
        action = mkRaw "grapple.tag";
        options = {
          silent = true;
          desc = "add tag to grapple";
        };
      }
      {
        mode = "n";
        key = "<leader>M";
        action = mkRaw "grapple.untag";
        options = {
          silent = true;
          desc = "remove tag of grapple";
        };
      }
      {
        mode = "n";
        key = "<leader>`";
        action = mkRaw "grapple.toggle_tags";
        options = {
          silent = true;
          desc = "show grapple menu";
        };
      }
      {
        mode = "n";
        key = "<leader>~";
        action = mkRaw "grapple.toggle_scopes";
        options = {
          silent = true;
          desc = "show grapple scopes menu";
        };
      }
    ]
    ++ builtins.genList (n: let
      i = toString (n + 1);
    in {
      mode = "n";
      key = "<leader>${i}";
      action = mkRaw ''
        function()
          if grapple.exists({index = ${i}}) then
            grapple.select({index = ${i}})
          end
        end'';
      options = {
        silent = true;
        desc = "select ${i} file in grapple";
      };
    })
    9;
}
