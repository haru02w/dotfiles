{
  perSystem.nvf.module.config.vim = {
    # mapleader defaults to " " in nvf; maplocalleader defaults to "," — override.
    globals.maplocalleader = " ";

    keymaps = [
      {
        mode = "x";
        key = "n";
        action = ''
          :<c-u>let temp_variable=@"<CR>gvy:<c-u>let @/='\V<C-R>=escape(@",'/\')<CR>'<CR>:let @"=temp_variable<CR>
        '';
        desc = "Search for the word under the cursor";
      }
      {
        mode = "n";
        key = "<leader>\\";
        action = "<cmd>sp<cr>";
        desc = "Horizontal split";
      }
      {
        mode = "n";
        key = "<leader>|";
        action = "<cmd>vs<cr>";
        desc = "Vertical split";
      }
      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
        desc = "Append next line without moving cursor";
      }
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        desc = "Move text down without losing selection";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        desc = "Move text up without losing selection";
      }
      # <C-d>zz and <C-u>zz are set up in mini.nix (mini.animate scroll +
      # MiniAnimate.execute_after recenter). Kept here as reference.
      # {
      #   mode = "n";
      #   key = "<C-d>";
      #   action = "<C-d><Cmd>lua MiniAnimate.execute_after('scroll', 'normal! zz')<CR>";
      #   desc = "Move cursor half page down while keeping cursor in the middle";
      # }
      # {
      #   mode = "n";
      #   key = "<C-u>";
      #   action = "<C-u><Cmd>lua MiniAnimate.execute_after('scroll', 'normal! zz')<CR>";
      #   desc = "Move cursor half page up keeping cursor in the middle";
      # }
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
        desc = "Next search term keeping cursor in the middle";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
        desc = "Previous search term keeping cursor in the middle";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        desc = "Indent left and keep selection";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        desc = "Indent right and keep selection";
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>nohlsearch<cr>";
        desc = "Disable highlight on search terms";
      }
      {
        mode = "n";
        key = "<leader>tw";
        action = "<cmd>set wrap!<cr>";
        desc = "Toggle wrap";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>d";
        action = ''"_d'';
        desc = "Delete without yanking";
      }
      {
        mode = "x";
        key = "<leader>p";
        action = ''"_dp'';
        desc = "Paste over without yanking";
      }
      {
        mode = "x";
        key = "<leader>P";
        action = ''"_dP'';
        desc = "Paste over without yanking";
      }
      {
        mode = "i";
        key = "<C-c>";
        action = "<Esc>";
        desc = "Quick esc";
      }
      {
        mode = "n";
        key = "<leader>bn";
        action = "<cmd>bnext<cr>";
        desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>bprevious<cr>";
        desc = "Previous buffer";
      }
    ];
  };
}
