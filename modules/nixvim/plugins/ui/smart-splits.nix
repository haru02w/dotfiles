{lib, ...}:
with lib.nixvim; {
  plugins.smart-splits.enable = true;
  extraConfigLua = "local splits = require('smart-splits')";
  keymaps = [
    {
      mode = "n";
      key = "<A-h>";
      action = mkRaw "splits.move_cursor_left";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-j>";
      action = mkRaw "splits.move_cursor_down";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-k>";
      action = mkRaw "splits.move_cursor_up";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-l>";
      action = mkRaw "splits.move_cursor_right";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-A-h>";
      action = mkRaw "splits.resize_left";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-A-j>";
      action = mkRaw "splits.resize_down";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-A-k>";
      action = mkRaw "splits.resize_up";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-A-l>";
      action = mkRaw "splits.resize_right";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-H>";
      action = mkRaw "splits.swap_buf_left";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-J>";
      action = mkRaw "splits.swap_buf_down";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-K>";
      action = mkRaw "splits.swap_buf_up";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-L>";
      action = mkRaw "splits.swap_buf_right";
      options.silent = true;
    }
  ];
}
