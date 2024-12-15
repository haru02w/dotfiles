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
      options = {
        silent = true;
        desc = "search by selected word";
      };
    }
    {
      mode = "n";
      key = "<leader>\\";
      action = "<cmd>sp<cr>";
      options = {
        silent = true;
        desc = "horizontal split";
      };
    }
    {
      mode = "n";
      key = "<leader>|";
      action = "<cmd>vs<cr>";
      options = {
        silent = true;
        desc = "vertical split";
      };
    }

    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options = {
        silent = true;
        desc = "move text down without losing selection";
      };
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options = {
        silent = true;
        desc = "move text up without losing selection";
      };
    }

    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
      options = {
        silent = true;
        desc = "append next line without moving cursor";
      };
    }

    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options = {
        silent = true;
        desc = "move cursor half page down while keeping cursor in the middle";
      };
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options = {
        silent = true;
        desc = "move cursor half page up keeping cursor in the middle";
      };
    }

    {
      mode = "n";
      key = "n";
      action = "nzzzv";
      options = {
        silent = true;
        desc = "Next search term keeping cursor in the middle";
      };
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
      options = {
        silent = true;
        desc = "Previous search term keeping cursor in the middle";
      };
    }
    {
      mode = "v";
      key = "<";
      action = "<gv";
      options = {
        silent = true;
        desc = "ident left and keep selection";
      };
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
      options = {
        silent = true;
        desc = "ident right and keep selection";
      };
    }

    {
      mode = "n";
      key = "<leader>n";
      action = "<cmd>nohlsearch<cr>";
      options = {
        silent = true;
        desc = "disable highlight on search terms";
      };
    }

    {
      # Paste stuff without saving the deleted word into the buffer
      mode = "x";
      key = "<leader>p";
      action = ''"_dp'';
      options.desc = "Deletes to void register and paste over";
    }
    {
      # Paste stuff without saving the deleted word into the buffer
      mode = "x";
      key = "<leader>P";
      action = ''"_dP'';
      options.desc = "Deletes to void register and paste over";
    }
    {
      # Delete to void register
      mode = ["n" "v"];
      key = "<leader>D";
      action = ''"_d'';
      options.desc = "Delete to void register";
    }
    {
      mode = "i";
      key = "<C-c>";
      action = "<Esc>";
    }
  ];
}
