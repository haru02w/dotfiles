return { -- TODO do it properly
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{ 'lukas-reineke/cmp-rg', lazy = true },
			{ 'hrsh7th/cmp-nvim-lsp', lazy = true },
			{ 'hrsh7th/cmp-buffer',   lazy = true },
			{ 'hrsh7th/cmp-path',     lazy = true },
			{ 'hrsh7th/cmp-cmdline',  lazy = true },
			{
				'L3MON4D3/LuaSnip',
				lazy = true,
				dependencies = {
					'rafamadriz/friendly-snippets',
					lazy = true,
					config = function()
						require('luasnip').filetype_extend('typescriptreact', { 'html' })
						require('luasnip.loaders.from_vscode').lazy_load()
					end,
				},
			},
			{
				'saadparwaiz1/cmp_luasnip',
				lazy = true,
				config = function()
					require('luasnip.config').setup({})
				end,
			},
			{ 'onsails/lspkind.nvim', lazy = true },
			'windwp/nvim-autopairs',
		},
		opts = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')
			local lspkind = require('lspkind')

			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

			-- `/` cmdline setup.
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' },
				},
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' },
				}, {
					{ name = 'cmdline' },
				}),
			})

			return {
				history = true,
				updateevents = 'TextChanged,TextChangedI',
				enable_autosnippets = true,
				-- region_check_events = 'InsertEnter',
				-- delete_check_events = 'InsertLeave',
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete({}), -- I can't even use it, lol
					['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),

					['<C-n>'] = cmp.mapping(function()
						if luasnip.jumpable(1) then
							luasnip.jump(1)
						else
							cmp.select_next_item()
						end
					end, { 'i', 's' }),
					['<C-p>'] = cmp.mapping(function()
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							cmp.select_prev_item()
						end
					end, { 'i', 's' }),
					['<C-x>'] = cmp.mapping(function()
						if luasnip.choice_active() then
							luasnip.change_choice(1)
						end
					end, { 'i', 's' }),
					['<Tab>'] = cmp.mapping(function(fallback)
						local col = vim.fn.col('.') - 1
						if cmp.visible() then
							cmp.select_next_item()
							--[[ elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump() ]]
						elseif col ~= 0 and vim.fn.getline('.'):sub(col, col):match('%s') == nil then
							cmp.complete()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
							--[[ elseif luasnip.jumpable(-1) then
              luasnip.jump(-1) ]]
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = {
					{ name = 'luasnip',  priority = 1000 },
					{ name = 'nvim_lsp', priority = 750 },
					{ name = 'buffer',   priority = 500 },
					{ name = 'path',     priority = 250 },
					{ name = 'rg',       priority = 200 },
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol', -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						--[[ before = function(entry, vim_item)
							return vim_item
						end, ]]
					}),
				},
			}
		end,
	},
}
