return {
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = { 'BufReadPost', 'BufNewFile' },
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		-- [[ Configure Treesitter ]]
		-- See `:help nvim-treesitter`
		opts = {
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				'c',
				'lua',
				'python',
				'rust',
				'typescript',
				'vimdoc',
				'vim',
				'markdown',
				'markdown_inline',
			},

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally = true,
			auto_install = true,

			highlight = { enable = true },
			indent = { enable = true, disable = { 'python' } },
			autotag = {
				enable = true,
			},
		},
		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
		end,
	},
}
