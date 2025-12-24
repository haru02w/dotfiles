{
  globals.mapleader = " ";
  globals.localmapleader = " ";

  keymaps = [
    {
      mode = "x";
      key = "n";
      action = ''
        :<c-u>let temp_variable=@"<CR>gvy:<c-u>let @/='\V<C-R>=escape(@",'/\')<CR>'<CR>:let @"=temp_variable<CR>
      '';
      options.desc = "Search for the word under the cursor";
    }
    {
      mode = "n";
      key = "<leader>\\";
      action = "<cmd>sp<cr>";
      options.desc = "Horizontal split";
    }
    {
      mode = "n";
      key = "<leader>|";
      action = "<cmd>vs<cr>";
      options.desc = "Vertical split";
    }
    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
      options.desc = "Append next line without moving cursor";
    }
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move text down without losing selection";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move text up without losing selection";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options.desc = "Move cursor half page down while keeping cursor in the middle";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options.desc = "Move cursor half page up keeping cursor in the middle";
    }
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
      options.desc = "Next search term keeping cursor in the middle";
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
      options.desc = "Previous search term keeping cursor in the middle";
    }
    {
      mode = "v";
      key = "<";
      action = "<gv";
      options.desc = "Indent left and keep selection";
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
      options.desc = "Indent right and keep selection";
    }
    {
      mode = "n";
      key = "<leader>n";
      action = "<cmd>nohlsearch<cr>";
      options.desc = "Disable highlight on search terms";
    }
    {
      mode = "n";
      key = "<leader>tw";
      action = "<cmd>set wrap!<cr>";
      options.desc = "Disable highlight on search terms";
    }
    {
      mode = ["n" "v"];
      key = "<leader>d";
      action = ''"_d'';
      options.desc = "Delete without yanking";
    }
    {
      mode = "x";
      key = "<leader>p";
      action = ''"_dp'';
      options.desc = "Paste over without yanking";
    }
    {
      mode = "x";
      key = "<leader>P";
      action = ''"_dP'';
      options.desc = "Paste over without yanking";
    }
    {
      mode = "i";
      key = "<C-c>";
      action = "<Esc>";
      options.desc = "Quick esc";
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>bnext<cr>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>bprevious<cr>";
      options.desc = "Previous buffer";
    }
    # Insert mode
    {
      mode = "i";
      key = "<C-h>";
      action = "<Left>";
      options = {
        desc = "left";
        nowait = true;
      };
    }
    {
      mode = "i";
      key = "<C-j>";
      action = "<Down>";
      options = {
        desc = "down";
        nowait = true;
      };
    }
    {
      mode = "i";
      key = "<C-k>";
      action = "<Up>";
      options = {
        desc = "up";
        nowait = true;
      };
    }
    {
      mode = "i";
      key = "<C-l>";
      action = "<Right>";
      options = {
        desc = "right";
        nowait = true;
      };
    }
  ];
}
