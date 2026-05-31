{ den, ... }:
{
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.trouble = {
      enable = true;
      settings = {
        auto_close = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>qD";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Toggle diagnostics list";
      }
      {
        mode = "n";
        key = "<leader>qd";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options.desc = "Toggle buffer diagnostics list";
      }
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>Trouble qflist toggle<cr>";
        options.desc = "Toggle quickfix list";
      }
      {
        mode = "n";
        key = "<leader>ql";
        action = "<cmd>Trouble loclist toggle<cr>";
        options.desc = "Toggle loclist list";
      }
      {
        mode = "n";
        key = "<leader>qL";
        action = "<cmd>Trouble lsp toggle win.position=right<cr>";
        options.desc = "Toggle LSP objects list";
      }
      {
        mode = "n";
        key = "<leader>ls";
        action = "<cmd>Trouble symbols toggle focus=true<cr>";
        options.desc = "Toggle symbols list";
      }
    ];
  };
}
