{
  opts = {
    encoding = "utf-8";
    fileencoding = "utf-8";
    # faster completion
    updatetime = 50;
    # show popup menu and don't auto select
    completeopt = [ "menuone" "noselect" "noinsert" ];
    # Enable indent in wrapped lines
    breakindent = true;
    mouse = "a";
    autoread = true;
    ignorecase = true;
    smartcase = true;
    number = true;
    relativenumber = true;
    signcolumn = "yes";
    shiftround = true;
    autoindent = true;
    smartindent = true;
    wrap = false;

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

    timeout = true;
    timeoutlen = 300;
    colorcolumn = "80";
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

    # testing
    cmdheight = 0;
    showmode = false;
  };
}
