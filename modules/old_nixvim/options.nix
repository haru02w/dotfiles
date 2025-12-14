{lib, ...}:
with lib.nixvim; {
  opts = {
    encoding = "utf-8";
    fileencoding = "utf-8";
    # faster completion
    updatetime = 300;
    # show popup menu and don't auto select
    completeopt = ["menuone" "noselect" "noinsert"];
    # Enable indent in wrapped lines
    breakindent = true;
    mouse = "a";
    autoread = true;
    autowrite = false;
    ignorecase = true;
    smartcase = true;
    number = true;
    relativenumber = true;
    signcolumn = "yes";
    shiftround = true;
    autoindent = true;
    smartindent = true;
    linebreak = true;
    wrap = true; # TODO: put a keybind to toggle it

    splitbelow = true;
    splitright = true;

    swapfile = false;
    backup = false;
    writebackup = false;
    undofile = true;

    # keep highlight in search terms
    hlsearch = true;
    # see search evaluation
    incsearch = true;
    # add offset for cursor
    scrolloff = 8;
    sidescrolloff = 8;

    timeout = true;
    timeoutlen = 500;
    colorcolumn = "80";
    showmatch = true;
    matchtime = 2;
    cursorline = true;
    termguicolors = true;

    # default indent
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    showtabline = 4;
    expandtab = true;

    # folding
    foldcolumn = "0";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;
  };
  diagnostic.settings = {
    underline.severity.max = mkRaw "vim.diagnostic.severity.WARN";
    virtual_text.severity.min = mkRaw "vim.diagnostic.severity.ERROR";
  };
}
