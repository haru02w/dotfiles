local M = {}
local keymap = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--[[
-- netrw:
-- gn to enter a directory
-- Enter to open a file or expand a directory
-- <leader>e open netrw
--]]
-- File Explorer
keymap('n', '<leader>e', vim.cmd.Ex, { desc = 'Open netrw (default File Explorer)' })
keymap('n', '<leader>q', vim.cmd.q, { desc = 'quicker [Q]uit' })
keymap('n', '<leader>w', function()
	vim.lsp.buf.format()
	vim.cmd.w()
end, { desc = 'Open netrw (default File Explorer)' })
-- Quick Split
keymap('n', '<leader>\\', vim.cmd.sp, { desc = 'Split screen' })
keymap('n', '<leader>|', vim.cmd.vs, { desc = 'Split screen vertically' })

-- Move lines around
keymap('v', '<C-j>', ':m \'>+1<CR>gv=gv', { desc = 'move selected lines down' })
keymap('v', '<C-k>', ':m \'<-2<CR>gv=gv', { desc = 'move selected lines up' })

-- Append next line without moving cursor
keymap('n', '<leader>j', 'mzJ`z', { desc = 'append next line' })

-- Disable J
keymap('n', 'J', '<Nop>')

-- Move half page around keeping cursor in the middle
keymap('n', '<C-d>', '<C-d>zz', { desc = 'move cursor half page down' })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'move cursor half page up' })

-- Next search term kepping cursor in the middle
keymap('n', 'n', 'nzzzv', { desc = 'next search term' })
keymap('n', 'N', 'Nzzzv', { desc = 'next search term' })

-- Use the system clipboard
keymap({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'copy to system clipboard' })
keymap('n', '<leader>Y', [["+Y]], { desc = 'copy to system clipboard the text at right of cursor' })
keymap({ 'n', 'v' }, '<leader>p', [["+p]], { desc = 'paste from system clipboard' })

-- Paste without losing yanked text
keymap('x', 'p', 'P', { desc = 'a better paste' })

-- remap normal p to <leader>p
keymap('x', '<leader>p', 'p', { desc = 'normal paste' })

-- Stay in indent mode
keymap('v', '<', '<gv', { desc = 'indent left' })
keymap('v', '>', '>gv', { desc = 'indent right' })

--disable search highlight
keymap('n', '<leader>n', vim.cmd.nohlsearch, { desc = 'disable search highlight' })

-- don't know why this exists
keymap('n', 'Q', '<nop>')

keymap('t', '<esc>', [[<C-\><C-n>]], { desc = 'get out of terminal mode' })
keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = 'move left window' })
keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = 'move down window' })
keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = 'move up window' })
keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = 'move right window' })
keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { desc = 'control windows' })

function M.lsp()
	-- Call hierarchy
	keymap('n', '<Leader>li', vim.lsp.buf.incoming_calls, { desc = '[L]sp [I]ncoming Calls' })
	keymap('n', '<Leader>lo', vim.lsp.buf.outgoing_calls, { desc = '[L]sp [O]utgoing Calls' })

	-- Floating terminal
	-- tmux leader + t

	-- Diagnostic keymaps
	keymap('n', '<leader>ld', vim.diagnostic.open_float)
	keymap('n', '[d', vim.diagnostic.goto_prev)
	keymap('n', ']d', vim.diagnostic.goto_next)

	keymap('n', '<leader>ll', '<cmd>SymbolsOutline<CR>', { desc = '[L]sp [O]utline' })

	keymap('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[L]sp [R]ename' })

	keymap('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
	keymap('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]efinition' })
	keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover docs' })
	keymap('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {})
	keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {})
	keymap('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, {})
	keymap('n', 'gt', vim.lsp.buf.type_definition, { desc = 'type [D]efinition' })
	keymap('n', 'gr', vim.lsp.buf.references, { desc = 'type [D]efinition' })
	keymap({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { desc = '[L]sp [A]ctions' })
	-- keymap('n', 'gr', vim.lsp.buf.references, { '[G]oto [R]eferences' })
	vim.keymap.set('n', '<leader>f', function()
		vim.lsp.buf.format({ async = true })
	end, { desc = '[F]ormat buffer' })
end

-- TODO: _____________________________________________________________________
function M.lspsaga()
	keymap('n', '<leader>lb', '<cmd>Lspsaga show_buf_diagnostics<CR>', { desc = 'Open diagnostics list' })
	keymap('n', 'gpd', '<cmd>Lspsaga peek_definition<CR>', { desc = '[G]oto [D]efinition' })
	keymap('n', 'gt', '<cmd>Lspsaga goto_type_definition<CR>', { desc = 'Type [D]efinition' })
	keymap('n', 'gpt', '<cmd>Lspsaga peek_type_definition<CR>', { desc = 'Type [D]efinition' })
	keymap('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', { desc = '[G]oto [R]eferences' })

	-- See `:help K` for why this keymap
	keymap('n', 'K', '<cmd>Lspsaga hover_doc ++keep<CR>', { desc = 'Hover Documentation' })
	-- Lesser used LSP functionality
	keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[W]orkspace [A]dd Folder' })
	keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '[W]orkspace [R]emove Folder' })
	keymap('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = '[W]orkspace [L]ist Folders' })
end

function M.telescope()
	local builtin = require('telescope.builtin')
	keymap('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
	keymap('n', '<leader>fG', builtin.git_files, { desc = '[f]ind [G]it files' })
	keymap('n', '<leader>fg', builtin.live_grep, { desc = '[f]ind [g]rep pattern' })
	keymap('n', '<leader>fb', builtin.buffers, { desc = '[f]ind on [b]uffers' })
	keymap('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind in [h]elp manuals' })
end

function M.smart_splits()
	local splits = require('smart-splits')
	-- resizing splits
	keymap('n', '<C-A-h>', splits.resize_left, { desc = 'Resize current window left' })
	keymap('n', '<C-A-j>', splits.resize_down, { desc = 'Resize current window down' })
	keymap('n', '<C-A-k>', splits.resize_up, { desc = 'Resize current window up' })
	keymap('n', '<C-A-l>', splits.resize_right, { desc = 'Resize current window right' })
	-- moving between splits
	keymap('n', '<C-h>', splits.move_cursor_left, { desc = 'Move focus to left window' })
	keymap('n', '<C-j>', splits.move_cursor_down, { desc = 'Move focus to down window' })
	keymap('n', '<C-k>', splits.move_cursor_up, { desc = 'Move focus to up window' })
	keymap('n', '<C-l>', splits.move_cursor_right, { desc = 'Move focus to right window' })
	-- swapping buffers between windows
	keymap('n', '<A-H>', splits.swap_buf_left, { desc = 'Swap current window with left one' })
	keymap('n', '<A-K>', splits.swap_buf_down, { desc = 'Swap current window with down one' })
	keymap('n', '<A-J>', splits.swap_buf_up, { desc = 'Swap current window with up one' })
	keymap('n', '<A-L>', splits.swap_buf_right, { desc = 'Swap current window with right one' })
end

function M.comment()
	local api = require('Comment.api')
	local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

	keymap('n', '<leader>/', api.toggle.linewise.current, { desc = 'linewise comment a line' })
	keymap('n', '<leader>?', api.toggle.blockwise.current, { desc = 'blockwise comment a line' })

	keymap('x', '<leader>/', function()
		vim.api.nvim_feedkeys(esc, 'nx', false)
		api.toggle.blockwise(vim.fn.visualmode())
	end, { desc = 'blockwise comment selected text' })

	keymap('x', '<leader>?', function()
		vim.api.nvim_feedkeys(esc, 'nx', false)
		api.toggle.linewise(vim.fn.visualmode())
	end, { desc = 'linewise comment selected text' })
end

function M.buffer_manager()
	-- Navigate buffers bypassing the menu
	local bmui = require('buffer_manager.ui')
	local keys = '1234567890'
	for i = 1, #keys do
		local key = keys:sub(i, i)
		keymap('n', string.format('<leader>%s', key), function()
			bmui.nav_file(i)
		end, { desc = 'Change to buffer at ' .. i })
	end
	keymap({ 't', 'n' }, '<leader>`', bmui.toggle_quick_menu, { desc = 'Open buffer list' })
end

function M.undotree()
	keymap('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndoTree Toggle' })
end

function M.fugitive()
	keymap('n', '<leader>G', vim.cmd.Git, { desc = 'Open Git Status' })
end

function M.spectre()
	keymap('n', '<leader>ss', '<cmd>lua require("spectre").open()<CR>', {
		desc = 'Open Spectre',
	})
	keymap('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
		desc = 'Search current word',
	})
	keymap('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
		desc = 'Search current word',
	})
	keymap('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
		desc = 'Search on current file',
	})
end

function M.zenmode()
	return {
		{ '<leader>zz', '<cmd>ZenMode<cr>', desc = 'Toggle zenmode' },
	}
end

function M.dap()
	keymap('n', '<F3>', require('dapui').toggle, { desc = 'toggle dap ui' })

	keymap('n', '<F5>', require('dap').continue, { desc = 'debug: continue program' })
	keymap('n', '<F17>', require('dap').terminate, { desc = 'debug: stop program' })     -- Shift + F5
	keymap('n', '<F29>', require('dap').restart_frame, { desc = 'debug: restart program' }) -- Control + F5

	keymap('n', '<F6>', require('dap').pause, { desc = 'debug: pause program' })
	keymap('n', '<F9>', require('dap').toggle_breakpoint, { desc = 'debug: toggle breakpoint' })
	keymap('n', '<F21>', function()
		require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
	end, { desc = 'debug: Conditional breakpoint' }) -- Shift + F9
	keymap('n', '<F10>', require('dap').step_over, { desc = 'debug: step over' })
	keymap('n', '<F11>', require('dap').step_into, { desc = 'debug: step into' })
	keymap('n', '<F23>', require('dap').step_out, { desc = 'debug: step out' }) -- Shift + F11
end

function M.oil()
	return {
		{ '-', vim.cmd.Oil, desc = 'Toggle zenmode' },
	}
end

function M.todo_comments()
	return {
		{
			']t',
			function()
				require('todo-comments').jump_next()
			end,
			desc = 'Next todo comment',
		},
		{
			'[t',
			function()
				require('todo-comments').jump_prev()
			end,
			desc = 'Previous todo comment',
		},
	}
end

return M
