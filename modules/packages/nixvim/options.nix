{
  perSystem = _: {
    nixvim.module = {
      viAlias = true;
      vimAlias = true;

      globals = {
        loaded_netrw = 1;
        loaded_netrwPlugin = 1;
      };

      colorschemes.oxocarbon.enable = true;
      # oxocarbon defines BlinkCmpMenuSelection as NONE/NONE, which shadows
      # blink's default link to PmenuSel and hides the selected item.
      highlightOverride.BlinkCmpMenuSelection.link = "PmenuSel";

      plugins.lz-n.enable = true;

      opts = {
        # previously nvf defaults
        number = true;
        relativenumber = true;
        swapfile = false;
        backup = false;
        writebackup = false;
        errorbells = false;
        belloff = "all";
        splitbelow = true;
        splitright = true;
        autoindent = true;
        wrap = true;
        termguicolors = true;
        signcolumn = "yes";
        updatetime = 300;
        timeoutlen = 500;
        encoding = "utf-8";
        hidden = true;
        expandtab = true;
        background = "dark";

        # search case = smart
        ignorecase = true;
        smartcase = true;

        undofile = true;

        # preferences
        cursorline = true;
        breakindent = true;
        linebreak = true;
        scrolloff = 10;
        sidescrolloff = 8;

        # indentation
        tabstop = 4;
        shiftwidth = 4;
        softtabstop = 4;
        shiftround = true;
        smartindent = false;

        # search
        hlsearch = true;
        incsearch = true;

        # visual
        winborder = "single";
        showtabline = 1;
        colorcolumn = "100";
        showmatch = true;
        matchtime = 2;
        completeopt = "menuone,noselect,noinsert";
        showmode = false;
        pumheight = 10;
        pumblend = 10;
        winblend = 0;
        conceallevel = 0;
        concealcursor = "";
        synmaxcol = 300;

        # file handling
        ttimeoutlen = 0;
        autoread = true;
        autowrite = false;

        # behavior
        backspace = "indent,eol,nostop";
        selection = "inclusive";
        mouse = "a";
        fileencoding = "utf-8";
        guicursor = "n-v-c-ve-sm:block,i-ci:ver25,r-cr:hor20,o:hor50";

        # command mode
        wildmenu = true;
        wildmode = "longest:full,full";

        # diff
        diffopt = "linematch:60";

        # fold
        foldlevel = 99;
        foldlevelstart = 99;
        foldenable = true;
        # keep syntax highlighting on folded lines (foldexpr comes from
        # treesitter, or LSP when the server supports folding ranges)
        foldtext = "";

        # performance
        redrawtime = 10000;
        maxmempattern = 20000;

        # clipboard
        clipboard = "unnamedplus";

        # load project-local .nvim.lua (asks to :trust it first)
        exrc = true;
      };

      extraConfigLua = ''
        vim.opt.iskeyword:append("-")
        vim.opt.path:append("**")

        -- experimental built-in messages/cmdline UI (no "Press ENTER" prompts)
        require('vim._core.ui2').enable({})

        -- built-in :Undotree
        vim.cmd.packadd('nvim.undotree')
      '';

      autoGroups.UserConfig.clear = true;

      autoCmd = [
        {
          event = [ "TextYankPost" ];
          group = "UserConfig";
          pattern = [ "*" ];
          desc = "Highlight yank";
          callback.__raw = ''
            function() vim.highlight.on_yank({timeout=300}) end
          '';
        }
        {
          event = [ "BufReadPost" ];
          group = "UserConfig";
          desc = "Return to last position in file";
          callback.__raw = ''
            function()
              local mark = vim.api.nvim_buf_get_mark(0, '"')
              local lcount = vim.api.nvim_buf_line_count(0)
              local line = mark[1]
              local ft = vim.bo.filetype

              if line > 0
                and line <= lcount
                and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
                and not vim.o.diff
              then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
              end
            end
          '';
        }
        {
          event = [ "VimResized" ];
          group = "UserConfig";
          desc = "Resize splits when window is resized";
          callback.__raw = ''
            function() vim.cmd("tabdo wincmd =") end
          '';
        }
        {
          event = [ "BufWritePre" ];
          group = "UserConfig";
          desc = "Create parent dir on save";
          callback.__raw = ''
            function()
              local dir = vim.fn.expand('<afile>:p:h')
              if vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, 'p')
              end
            end
          '';
        }
      ];
    };
  };
}
