{
  pkgs,
  lib,
  inputs,
  ...
}:
with lib.nixvim; let
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };
in {
  extraPlugins = [
    (mkNvimPlugin inputs.buffer_manager-nvim
      "buffer_manager.nvim") # manage buffers
  ];

  extraConfigLua = ''
    require('buffer_manager').setup({
      line_keys = "",
      win_extra_options = {
        number = true,
        relativenumber = true,
      },
    })
  '';
  keymaps =
    [
      {
        mode = ["n" "t"];
        key = "<leader>`";
        action = mkRaw "require('buffer_manager.ui').toggle_quick_menu";
        options = {
          silent = true;
          desc = "show buffer_manager menu";
        };
      }
    ]
    ++ builtins.genList (n: let
      i = toString (n + 1);
    in {
      mode = "n";
      key = "<leader>${i}";
      action = mkRaw "function() require('buffer_manager.ui').nav_file(${i}) end";
      options = {
        #noremap = true;
        # silent = true;
        desc = "select ${i} file in buffer_manager";
      };
    })
    9;
}
