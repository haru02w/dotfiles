{lib, ...}:
with lib.nixvim; {
  plugins.smart-splits.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<A-h>";
      action = mkRaw "require('smart-splits').move_cursor_left";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-j>";
      action = mkRaw "require('smart-splits').move_cursor_down";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-k>";
      action = mkRaw "require('smart-splits').move_cursor_up";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-l>";
      action = mkRaw "require('smart-splits').move_cursor_right";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-A-h>";
      action = mkRaw "require('smart-splits').resize_left";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-A-j>";
      action = mkRaw "require('smart-splits').resize_down";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-A-k>";
      action = mkRaw "require('smart-splits').resize_up";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-A-l>";
      action = mkRaw "require('smart-splits').resize_right";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-H>";
      action = mkRaw "require('smart-splits').swap_buf_left";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-J>";
      action = mkRaw "require('smart-splits').swap_buf_down";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-K>";
      action = mkRaw "require('smart-splits').swap_buf_up";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<A-L>";
      action = mkRaw "require('smart-splits').swap_buf_right";
      options.silent = true;
    }
  ];
}
