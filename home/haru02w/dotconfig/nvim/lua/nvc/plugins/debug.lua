return { -- TODO search how to configure it properly
	{
		'mfussenegger/nvim-dap',
		lazy = true,
	},
	{
		'jay-babu/mason-nvim-dap.nvim',
		event = 'VeryLazy',
		dependencies = {
			'mfussenegger/nvim-dap',
			'williamboman/mason.nvim',
		},
		opts = {},
		config = function()
			require('mason-nvim-dap').setup({
				ensure_installed = { 'stylua', 'jq', 'cpptools' },
				automatic_installation = true,
				handlers = {}, -- sets up dap in the predefined manner
			})
		end,
	},
	{
		'rcarriga/nvim-dap-ui',
		dependencies = { 'mfussenegger/nvim-dap' },
		opts = {},
		config = function(_, opts)
			local dap, dapui = require('dap'), require('dapui')
			dapui.setup(opts)
			dap.listeners.after.event_initialized['dapui_config'] = function()
				dapui.open()
			end
			require('nvc.keymaps').dap()
		end,
	},
}
