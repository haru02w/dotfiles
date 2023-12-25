return {}
--[[ return {
	{
		'jose-elias-alvarez/null-ls.nvim',
		lazy = true,
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		'jay-babu/mason-null-ls.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			'williamboman/mason.nvim',
			'jose-elias-alvarez/null-ls.nvim',
		},
		config = function()
			local null_ls = require('null-ls')
			local formatting = null_ls.builtins.formatting
			-- local diagnostics = null_ls.builtins.diagnostics
			-- local completion = null_ls.builtins.completion
			-- null-ls has priority
			null_ls.setup({
				sources = {
					-- null_ls.builtins.code_actions.gitsigns, -- too many messages
					formatting.stylua.with({ extra_args = { '--quote-style', 'ForceSingle' } }),
					formatting.prettierd.with({ extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' } }),
				},
			})

			require('mason-null-ls').setup({
				automatic_setup = true,
				ensure_installed = {
					'prettierd',
					-- Opt to list sources here, when available in mason.
				},
				automatic_installation = true,
				handlers = {},
			})
		end,
	},
} ]]
