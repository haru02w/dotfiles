local o = vim.opt
-- netrw relativenumbers
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
vim.g.netrw_liststyle = 3
-- change root dir with netrw
vim.g.netrw_keepdir = 0

-- Enable format-on-save from LSP
--[[ vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()
  end
}) ]]
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Treat .h files as C files
vim.cmd [[
  autocmd BufNewFile,BufRead *.h set filetype=c
]]

o.encoding = 'utf-8'
o.fileencoding = 'utf-8'

-- Set completeopt to have a better completion experience (TODO why?)
o.completeopt = 'menuone,noselect'

-- Enable break indent (TODO why this is useful?)
o.breakindent = true

o.mouse = 'a'   -- Enable mouse

o.cmdheight = 0 -- disable reserved line for commands
-- o.autochdir = false -- update current directory based on the opened file

o.autoread = true       -- read changes to file automatically
o.laststatus = 3        -- statusline: 0-never, 1-more than two windows, 2-always, 3-only the last

o.ignorecase = true     -- disable case sensitiviness on search
o.smartcase = true      -- enable back when a capital letter is written

o.number = true         --enable numbers
o.relativenumber = true --enable relative numbers

-- Keep signcolumn on by default
o.signcolumn = 'yes'
-- fix indent
o.expandtab = false -- no spaces
o.tabstop = 4       -- tab size
o.softtabstop = 4   --tab size 2
o.shiftwidth = 4    --tab size for autoindent
o.shiftround = true -- round tabs to shiftwidth
o.smartindent = true

o.wrap = false --don't wrap lines

o.swapfile = false
o.backup = false
o.undodir = os.getenv('HOME') .. '/.local/share/nvim/undodir'
o.undofile = true

o.hlsearch = true      --keep highlights enabled (see keymaps to fast disable)
o.incsearch = true     --guide the search you're doing

o.termguicolors = true -- good colors

o.scrolloff = 8        -- centralize the cursor a little

-- Decrease update time
o.updatetime = 50
o.timeout = true
o.timeoutlen = 300

o.colorcolumn = '80' -- good code belongs is in less than 80 lines
o.cursorline = true  -- to easily track the cursor
