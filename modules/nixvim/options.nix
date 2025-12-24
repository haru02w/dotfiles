{lib, ...}:
with lib.nixvim; {
  colorschemes.base16 = {
    enable = true;
    colorscheme = lib.mkDefault "tokyo-night-dark";
  };
  # colorscheme tweaks options
  highlight = {
    Normal = {
      bg = "none";
    };
    NormalFloat = {
      bg = "none";
    };
    FloatBorder = {
      bg = "none";
    };
    NormalNC = {
      bg = "none";
    };
    EndOfBuffer = {
      bg = "none";
    };
  };
  opts = {
    # preferences
    number = true;
    relativenumber = true;
    cursorline = true;
    wrap = false; # TODO: <leader>tw to toggle wrap
    breakindent = true;
    linebreak = true;
    scrolloff = 10;
    sidescrolloff = 8;

    # default indentation
    tabstop = 4;
    shiftwidth = 4;
    softtabstop = 4;
    shiftround = true;
    expandtab = true;
    smartindent = false; # This is not `smart` enougth
    autoindent = true;

    # search
    ignorecase = true;
    smartcase = true;
    hlsearch = true; # TODO: <leader>on to toggle it
    incsearch = true;

    # visual
    winborder = "single";
    showtabline = 1;
    termguicolors = true;
    signcolumn = "yes";
    colorcolumn = "100";
    showmatch = true;
    matchtime = 2;
    # cmdheight = 1; # Maybe do not use this. Lualine already "does" this.
    completeopt = ["menuone" "noselect" "noinsert"];
    showmode = false;
    pumheight = 10;
    pumblend = 10;
    winblend = 0;
    conceallevel = 0;
    concealcursor = "";
    # lazyredraw = true;
    synmaxcol = 300;

    # file handling
    backup = false;
    writebackup = false;
    swapfile = false;
    undofile = true;
    updatetime = 300; # time to save changes on disk
    timeoutlen = 500; # time to wait for sequence keypresses
    ttimeoutlen = 0;
    autoread = true; # autoreload files with changes
    autowrite = false; # disable

    # behavior settings
    hidden = true;
    errorbells = false;
    backspace = ["indent" "eol" "nostop"]; # better backspace behavior
    autochdir = false;
    selection = "inclusive"; # default TODO: toggle it to exclusive
    mouse = "a";
    modifiable = true; # allow buffer modifications
    encoding = "utf-8";
    fileencoding = "utf-8";
    guicursor = ["n-v-c-ve-sm:block" "i-ci:ver25" "r-cr:hor20" "o:hor50"];

    # command mode settings
    wildmenu = true;
    wildmode = ["longest:full" "full"];

    # better diff
    diffopt = "linematch:60";

    # split behavior
    splitright = true;
    splitbelow = true;

    # fold settings (TODO: maybe review this)
    foldmethod = "expr";
    foldexpr = "nvim_treesitter#folderexpr()"; # WARN: treesitter dependency
    foldlevel = 99; # starts aways unfolded

    # performance
    redrawtime = 10000;
    maxmempattern = 20000;
  };
  extraConfigLua = ''
    vim.opt.iskeyword:append("-") -- consider `-` as part of a word
    vim.opt.path:append("**") -- recurse on paths to search
  '';

  clipboard = {
    register = "unnamedplus";
  };

  autoGroups = {
    UserConfig = {
      clear = true;
    };
  };
  autoCmd = [
    {
      # Highlight yank
      event = "TextYankPost";
      group = "UserConfig";
      callback = mkRaw "function() vim.highlight.on_yank({timeout=300}) end";
      pattern = "*";
    }
    {
      # Return to last position in file
      event = "BufReadPost";
      group = "UserConfig";
      callback = mkRaw ''
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
      # Resize splits when window is resized
      event = "VimResized";
      group = "UserConfig";
      callback = mkRaw ''function() vim.cmd("tabdo wincmd =") end'';
    }
    {
      event = "BufWritePre";
      group = "UserConfig";
      callback = mkRaw ''        function()
                local dir = vim.fn.expand('<afile>:p:h')
                if vim.fn.isdirectory(dir) == 0 then
                  vim.fn.mkdir(dir, 'p')
                end
              end'';
    }
  ];

  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      luaLib = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
  luaLoader.enable = true;

  viAlias = true;
  vimAlias = true;
  waylandSupport = true;
}
