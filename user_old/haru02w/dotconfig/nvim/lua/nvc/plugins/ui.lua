return {
	{
		-- Default UI ================
		-- Theme inspired by Atom
		'navarasu/onedark.nvim',
		lazy = false,
		priority = 1000,
		opts = {
			style = 'deep',
			highlights = {
				Search = { bg = '#8B8000' },
			},
		},
		config = function(_, opts)
			require('onedark').setup(opts)
			require('onedark').load()
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		lazy = false,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			--[[ local function clock()
				return "󰅐 " .. os.date("%H:%M:%S")
			end ]]
			require('lualine').setup({
				sections = {
					lualine_c = {
						{ 'filename', path = 4 },
					},
					--[[ lualine_y = {
						{ clock, color = { fg = "#d78700" } },
					}, ]]
				},
			})
		end,
	}, -- Default UI ================
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		dependencies = {
			'MunifTanjim/nui.nvim',
		},
		opts = {
			views = {
				cmdline = {
					position = {
						row = -1,
						col = 0,
					},
				},
				mini = {
					timeout = 1500,
					reverse = false,
					position = {
						row = 1,
						col = '100%',
					},
				},
			},
			cmdline = {
				enabled = true, -- enables the Noice cmdline UI
				view = 'cmdline', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
				opts = {}, -- global options for the cmdline. See section on views
				format = {
					filter = false,
					lua = false,
					help = false,
				},
			},
			messages = {
				view = 'mini', -- default view for messages
				view_error = 'popup', -- view for errors
				view_warn = 'mini', -- view for warnings
			},
			popupmenu = { backend = 'cmp' },
			lsp = {
				progress = {
					enabled = false,
				},
			},
			presets = {
				long_message_to_split = true,
			},
		},
	},
	{
		'MunifTanjim/nui.nvim',
		lazy = true,
	},
	--[[ {
		"vimpostor/vim-tpipeline",
		lazy = false,
		config = function()
			vim.g.tpipeline_focuslost = 1
			vim.g.tpipeline_restore = 1
		end,
	}, ]]
	{
		-- Lua
		'folke/zen-mode.nvim',
		opts = {
			window = {
				width = 85,
			},
		},
		keys = require('nvc.keymaps').zenmode(),
	},
	{
		'nvim-tree/nvim-web-devicons',
		lazy = true,
		opts = {},
	},
	{
		'stevearc/dressing.nvim',
		event = 'VeryLazy',
		opts = {},
	},
}
