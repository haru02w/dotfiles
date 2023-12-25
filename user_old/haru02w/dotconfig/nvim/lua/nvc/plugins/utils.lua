return {
	{
		'j-morano/buffer_manager.nvim',
		event = 'VeryLazy',
		config = function()
			require('buffer_manager').setup({
				line_keys = '',
				win_extra_options = {
					number = true,
					relativenumber = true,
				},
			})
			require('nvc.keymaps').buffer_manager()
		end,
	},
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {},
	},
	{
		'kevinhwang91/nvim-fFHighlight',
		event = 'VeryLazy',
		opts = {
			number_hint_threshold = 2,
		},
	},
	{
		'nvim-pack/nvim-spectre',
		event = 'VeryLazy',
		config = function()
			require('spectre').setup()
			require('nvc.keymaps').spectre()
		end,
	},
	{
		'mbbill/undotree',
		cmd = 'UndotreeToggle',
		config = require('nvc.keymaps').undotree(),
	},
	{
		'tpope/vim-fugitive',
		cmd = 'Git',
		config = require('nvc.keymaps').fugitive(),
	},
	{ 'tpope/vim-rhubarb', lazy = true }, -- TODO ??
	{
		-- Library for other plugins
		'nvim-lua/plenary.nvim',
		lazy = true,
	},
}
