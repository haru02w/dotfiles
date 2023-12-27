return {
	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		event = 'VeryLazy',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						['<C-n>'] = 'move_selection_next',
						['<C-p>'] = 'move_selection_previous',
					},
				},
			},
		},
		config = function(_, opts)
			require('telescope').setup(opts)
			require('nvc.keymaps').telescope()
			--require('telescope').load_extension('fzf')
		end,
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		lazy = true,
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = 'make',
		cond = function()
			return vim.fn.executable('make') == 1
		end,
	},
}
