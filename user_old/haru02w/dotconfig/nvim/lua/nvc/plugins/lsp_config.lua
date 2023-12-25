return {
	{
		-- NOTE: This is where your plugins related to LSP can be installed.
		--  The configuration is done below. Search for lspconfig to find it below.
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{
				-- Useful status updates for LSP
				'j-hui/fidget.nvim',
				branch = 'legacy',
				lazy = true,
				opts = {},
			},
			{
				-- Additional lua configuration, makes nvim stuff amazing!
				'folke/neodev.nvim',
				lazy = true,
				opts = {
					library = { plugins = { 'nvim-dap-ui' }, types = true },
				},
			},
		},
		config = function()
			require('nvc.keymaps').lsp()
		end,
	},
	-- Automatically install LSPs to stdpath for neovim
	{
		'williamboman/mason.nvim',
		build = ':MasonUpdate',
		lazy = true,
		event = 'VeryLazy',
		opts = {},
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'williamboman/mason.nvim',
			'neovim/nvim-lspconfig',
		},
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			automatic_installation = true,
		},
		config = function(_, opts)
			local mason = require('mason-lspconfig')
			mason.setup(opts)
			local servers = {
				-- clangd = {}, ...
				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			}

			local capabilities =
				require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local on_attach = nil
			mason.setup_handlers({
				function(server_name)
					require('lspconfig')[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = servers[server_name],
					})
				end,
				['jdtls'] = function()
					require('lspconfig').jdtls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						root_dir = require('lspconfig').util.root_pattern('pom.xml', 'build.gradle', '.git')
							or vim.fn.getcwd(),
					})
				end,
				['clangd'] = function()
					require('lspconfig').clangd.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						cmd = {
							'clangd',
							'--offset-encoding=utf-16',
						},
					})
				end,
			})
		end,
	},
	--[[ {
		-- LSP UI
		'nvimdev/lspsaga.nvim',
		event = 'LspAttach',
		opts = {
			auto_resize = true,
			ui = {
				-- This option only works in Neovim 0.9
				title = true,
				-- Border type can be single, double, rounded, solid, shadow.
				border = 'rounded',
				winblend = 0,
				expand = '',
				collapse = '',
				code_action = '',
				incoming = '󰃋 ',
				outgoing = '󰃎 ',
				hover = ' ',
				kind = {},
			},
			code_action = {
				max_width = 0.7,
				max_height = 0.6,
				max_show_width = 0.9,
				max_show_height = 0.6,
			},
		},
		config = function(_, opts)
			require('lspsaga').setup(opts)
			require('nvc.keymaps').lspsaga()
		end,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			--Please make sure you install markdown and markdown_inline parser
			'nvim-treesitter/nvim-treesitter',
		},
	}, ]]
	{
		'ldelossa/litee-calltree.nvim',
		dependencies = { 'ldelossa/litee.nvim', lasy = true },
		event = 'VeryLazy',
	},
	{
		'simrat39/symbols-outline.nvim',
		cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose' },
		opts = {},
	},
	{
		'akinsho/flutter-tools.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
		config = true,
	}
}
