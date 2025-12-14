# disable backgroud
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})
vim.api.nvim_set_hl(0, "EndOfBuffer", {bg = "none"})

# [!IMPORTANT]
vim.opt.winborder = "rounded"

# Behaviour options
vim.opt.hidden = true                              -- Allow hidden buffers
vim.opt.errorbells = false                         -- No error bells
vim.opt.backspace = "indent,eol,start"             -- Better backspace behavior
vim.opt.autochdir = false                          -- Don't auto change directory (important)
vim.opt.iskeyword:append("-")                      -- Treat dash as part of word (important)
vim.opt.path:append("**")                          -- include subdirectories in search (important)
vim.opt.selection = "exclusive"                    -- Selection behavior
vim.opt.mouse = "a"                                -- Enable mouse support (important)
vim.opt.clipboard:append("unnamedplus")            -- Use system clipboard (important)
vim.opt.modifiable = true                          -- Allow buffer modifications
vim.opt.encoding = "UTF-8"                         -- Set encoding

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

# Keymaps
## C-S and C-q maybe C-a too
https://youtu.be/t6IY5W0NdS8?si=HNpkrGeW59ecxOcb&t=396

---

vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
-- Better paste behavior
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

# autocmd
-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

# plugins
vim-tpipeline
vim-tmux-navigator (change from ctrl-hjkl to ctrl-w-hjkl)
tabout
remove Comment.nvim (builtin now)
treesj
mini.surround
yazi (removing Oil, probably)
oil (if I keep, change to using float instead)
mini.pick (maybe, to use instead of telescope)

# external tools
yazi

# native harpoon (or just add the plugin)
vim.keymap.set("n", "<leader>a", function()
    vim.cmd("argadd %")
    vim.cmd("argdedup")
end)

vim.keymap.set("n", "<leader>e", function()
    vim.cmd.args()
end)

vim.keymap.set("n", "<leader>e", function()
    vim.cmd.args()
end)

vim.keymap.set("n", "<C-h>", function()
    vim.cmd("silent! 1argument")
end)
vim.keymap.set("n", "<C-h>", function()
    vim.cmd("silent! 2argument")
end)
vim.keymap.set("n", "<C-h>", function()
    vim.cmd("silent! 3argument")
end)
vim.keymap.set("n", "<C-h>", function()
    vim.cmd("silent! 4argument")
end)

# tmux
set -g history-limit 50000
-- setup ressurect right

## floating terminal
https://youtu.be/JN4Zbs0ypwM?si=nymKZIqIq3BYyxho&t=1369
## popup for leader S
https://youtu.be/JN4Zbs0ypwM?si=zL3MWQZ-yHi2gWOe&t=1251
## lazygit
https://youtu.be/JN4Zbs0ypwM?si=DIcCOItMS4ruUJKd&t=1845



