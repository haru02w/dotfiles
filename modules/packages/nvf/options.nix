{
  perSystem = _: {
    nvf.module =
      { lib, ... }:
      {
        config.vim = {
          viAlias = true;
          vimAlias = true;

          globals = {
            loaded_netrw = 1;
            loaded_netrwPlugin = 1;
          };

          theme = {
            enable = true;
            name = "oxocarbon";
            style = "dark";
          };

          lazy.enable = true;

          # nvf defaults: lineNumberMode = "relNumber" (number + relativenumber),
          # preventJunkFiles = true (no swap/backup/writebackup), bell = "none"
          # (no errorbells), splitbelow/splitright/autoindent/wrap/termguicolors/
          # signcolumn="yes"/updatetime=300/timeoutlen=500/encoding="utf-8"/
          # hidden=true/expandtab=true/maplocalleader="," (we override below).
          searchCase = "smart";
          undoFile.enable = true;

          options = {
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

            # performance
            redrawtime = 10000;
            maxmempattern = 20000;

            # clipboard
            clipboard = "unnamedplus";
          };

          luaConfigRC.user-extras = ''
            vim.opt.iskeyword:append("-")
            vim.opt.path:append("**")
          '';

          augroups = [
            {
              name = "UserConfig";
              clear = true;
            }
          ];

          autocmds = [
            {
              event = [ "TextYankPost" ];
              group = "UserConfig";
              pattern = [ "*" ];
              desc = "Highlight yank";
              callback = lib.generators.mkLuaInline ''
                function() vim.highlight.on_yank({timeout=300}) end
              '';
            }
            {
              event = [ "BufReadPost" ];
              group = "UserConfig";
              desc = "Return to last position in file";
              callback = lib.generators.mkLuaInline ''
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
              callback = lib.generators.mkLuaInline ''
                function() vim.cmd("tabdo wincmd =") end
              '';
            }
            {
              event = [ "BufWritePre" ];
              group = "UserConfig";
              desc = "Create parent dir on save";
              callback = lib.generators.mkLuaInline ''
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
  };
}
